use v6;

use Test;
use LibXML::Writer::Buffer;
use Pod::To::PDF::XML::Writer;

plan 1;

my $xml = q{<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE Document SYSTEM "http://pdf-raku.github.io/dtd/tagged-pdf.dtd">
<Document Lang="en">
  <!-- Example taken from docs.raku.org/language/pod#Declarator_blocks -->
  <Div role="Declaration">
    <H2>Class Magician</H2>
    <P>Base class for magicians</P>
    <Code Placement="Block">class Magician</Code>
  </Div>
  <Div role="Declaration">
    <H3>Sub duel</H3>
    <P>Fight mechanics</P>
    <Code Placement="Block">sub duel(
    Magician $a,
    Magician $b,
)</Code>
    <P>Magicians only, no mortals.</P>
  </Div>
</Document>
};

my LibXML::Writer::Buffer $doc .= new;
my Pod::To::PDF::XML::Writer $writer .= new: :$doc;
$writer.render($=pod);
is $doc.Str, $xml,
   'Declarators convert correctly.';

=comment Example taken from docs.raku.org/language/pod#Declarator_blocks

#| Base class for magicians 
class Magician {
  has Int $.level;
  has Str @.spells;
}
 
#| Fight mechanics 
sub duel(Magician $a, Magician $b) {
}
#= Magicians only, no mortals. 

