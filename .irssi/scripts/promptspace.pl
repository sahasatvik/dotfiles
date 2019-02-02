use strict;
use Irssi;
use Irssi::TextUI;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'Satvik Saha',
    name        => 'promptspace',
    description => 'Adjusts the prompt spacing',
    sbitems     => 'promptspace',
    license     => 'GNU GPLv2 or later',
);

Irssi::statusbar_item_register('promptspace', 0, 'promptspace');
Irssi::signal_add('window changed', 'promptspace_redraw');

# Called to make the status bar item
sub promptspace {
  my ($item, $get_size_only) = @_;
  
  my $wi = !Irssi::active_win() ? undef : Irssi::active_win()->{active};

  if(!ref $wi || uc($wi->{type}) ne "CHANNEL") { # only works on channels
    return unless ref $item;
    $item->{min_size} = $item->{max_size} = 0;
    return;
  }
  
  my $nick = Irssi::active_server()->{nick};
  my $format = sprintf(" %%X7E%16s %%K:%%n ", $nick);
  
  $item->{min_size} = $item->{max_size} = length($format);
  $item->default_handler($get_size_only, $format, undef, 1);
}

sub promptspace_redraw {
  Irssi::statusbar_items_redraw('promptspace');
}
