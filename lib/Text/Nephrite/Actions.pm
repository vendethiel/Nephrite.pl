class Text::Nephrite::Actions;

class Document {
  has @.children;
}

class Tag {
  has $.tag;
  has @.children;
}

method TOP($/) {
  make Document.new(:children($<lines>.?made));
}

method lines($/) {
  make $<line>.map(*.made);
}

method line($/) { # TODO proto
  make $<line-full>.?made; # ()
}

method line-full($/) {
  if $<tag> {
    make Tag.new(
      :tag(~$<tag>),
      :children($<lines>.?made)
    );
  } else { # just plain text
    
    if $<lines> {
      die "wtf dude y u indent on text";
    }
  }
}
