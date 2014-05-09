module Text::Jade;

use Text::Jade::Grammar;
#use Text::Jade::Actions;

say Text::Jade::Grammar.parse().perl;

sub parse(Str $txt --> :()) is export {
	my $actions = Text::Jade::Actions.new();
	my $parsed = Text::Jade::Grammar.parse();
	return $parsed.ast;
}