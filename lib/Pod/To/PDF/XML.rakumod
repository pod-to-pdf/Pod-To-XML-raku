unit class Pod::To::PDF::XML;

use Pod::To::PDF::XML::Writer;
use LibXML::Writer::File;

method render (
    $class: $pod,
    Str:D :$save-as is copy = '-',
    |c
) {
    state %cache{Any};
    %cache{$pod} //= do {
        my Bool $show-usage;
        for @*ARGS {
            when /^'--save-as='(.+)$/  { $save-as = $0.Str }
            default {  $show-usage = True; note "ignoring $_ argument" } 
        }
         note '(valid options are: --save-as=)'
             if $show-usage;
    }
    my LibXML::Writer::File $doc .= new: :file($save-as);
    my Pod::To::PDF::XML::Writer $writer .= new: :$doc, |c;
    $writer.render($pod);
    $save-as eq '-'
        ?? ''
        !! $save-as;
}
