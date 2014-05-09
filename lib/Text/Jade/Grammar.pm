grammar Text::Jade::Grammar;

token line {
	<selector> <value>
	| '|' <text>
}

regex code {
	<-[\n]>
	# add quoted string here and such
}

regex text {
	<-[\n]>
	# todo interpolation ...
}

regex interpolation {
	'#{' ~ '}'
	.+?
}

rule value:sym<=> {
	'=' <code>
}

rule value:sym<|> {
	<text>
}

token ident { :i
	<[a..z _ -]>
}

token id {
	'#' <ident>
}

token class {
	'.' <ident>
}

token quoted-string:sym<"> {
	'"' ~ '"'
	<-["]>
}

token quoted-string:sym<'> {
	'"' ~ '"'
	<-[']>
}

# Selector
token selector {
	$<tag>=<ident> ? # defaults to `div` # TODO also needs interpolation
	<id> ?
	<classes> *
	<attributes> *
}

# Attributes
token attributes:sym<()> {
	'(' ~ ')'
	<ident> '=' <code>
}

token attributes:sym<{}> {
	'{' ~ '}'
	[
	| <ident> ':' <code>
	| ':' <ident> <.ws> '=>' <.ws> <code> # does "code" support arrays ? if it's embeddable p6, it'll
	] *
}
