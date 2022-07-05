package SPVM::Errno;

our $VERSION = '0.01';

1;

=head1 Name

SPVM::Errno - Errno is a SPVM module

=head1 Synopsys

  use Errno;
  my $errno = Errno->errno;
  
=head1 Description

C<Errno> is a L<SPVM> module.

=head1 Class Methods

=head2 errno

  static method errno : int ()

Get error number. This is the same as C<errno> defined in C<errno.h> of C<C language>.

=head1 Repository

L<https://github.com/yuki-kimoto/SPVM-Errno>

=head1 Author

Yuki Kimoto C<kimoto.yuki@gmail.com>

=head1 Copyright & License

Copyright 2022-2022 Yuki Kimoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

