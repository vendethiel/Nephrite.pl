use lib 'lib/';
use Test;
use Text::Nephrite;

sub gram($txt) {
  my $parsed = Text::Nephrite::Grammar.parse($txt);
  $parsed.ast;
}

sub tag($tag) {
  Text::Nephrite::Tag.new(:$tag);
}

plan 1;

is gram('div'), (tag('div'),), 'A single, self-closed tag';
