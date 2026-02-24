use Test::More;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Errno';

my $os = $^O;
my $is_linux   = ($os eq 'linux');
my $is_darwin  = ($os eq 'darwin');
my $is_windows = ($os eq 'MSWin32' || $os eq 'cygwin' || $os eq 'msys');

# --- Expectations for Linux ---
my %linux_vals = (
    E2BIG => 7, EACCES => 13, EADDRINUSE => 98, EADDRNOTAVAIL => 99, EAFNOSUPPORT => 97,
    EAGAIN => 11, EALREADY => 114, EBADE => 52, EBADF => 9, EBADFD => 77, EBADMSG => 74,
    EBADR => 53, EBADRQC => 56, EBADSLT => 57, EBUSY => 16, ECANCELED => 125, ECHILD => 10,
    ECHRNG => 44, ECOMM => 70, ECONNABORTED => 103, ECONNREFUSED => 111, ECONNRESET => 104,
    EDEADLK => 35, EDEADLOCK => 35, EDESTADDRREQ => 89, EDOM => 33, EDQUOT => 122,
    EEXIST => 17, EFAULT => 14, EFBIG => 27, EHOSTDOWN => 112, EHOSTUNREACH => 113,
    EIDRM => 43, EILSEQ => 84, EINPROGRESS => 115, EINTR => 4, EINVAL => 22, EIO => 5,
    EISCONN => 106, EISDIR => 21, EISNAM => 120, EKEYEXPIRED => 127, EKEYREJECTED => 129,
    EKEYREVOKED => 128, EL2HLT => 51, EL2NSYNC => 45, EL3HLT => 46, EL3RST => 47,
    ELIBACC => 79, ELIBBAD => 80, ELIBMAX => 82, ELIBSCN => 81, ELIBEXEC => 83,
    ELOOP => 40, EMEDIUMTYPE => 124, EMFILE => 24, EMLINK => 31, EMSGSIZE => 90,
    EMULTIHOP => 72, ENAMETOOLONG => 36, ENETDOWN => 100, ENETRESET => 102, ENETUNREACH => 101,
    ENFILE => 23, ENOBUFS => 105, ENODATA => 61, ENODEV => 19, ENOENT => 2, ENOEXEC => 8,
    ENOKEY => 126, ENOLCK => 37, ENOLINK => 67, ENOMEDIUM => 123, ENOMEM => 12,
    ENOMSG => 42, ENONET => 64, ENOPKG => 65, ENOPROTOOPT => 92, ENOSPC => 28,
    ENOSR => 63, ENOSTR => 60, ENOSYS => 38, ENOTBLK => 15, ENOTCONN => 107,
    ENOTDIR => 20, ENOTEMPTY => 39, ENOTSOCK => 88, ENOTSUP => 95, ENOTTY => 25,
    ENOTUNIQ => 76, ENXIO => 6, EOPNOTSUPP => 95, EOVERFLOW => 75, EPERM => 1,
    EPFNOSUPPORT => 96, EPIPE => 32, EPROTO => 71, EPROTONOSUPPORT => 93, EPROTOTYPE => 91,
    ERANGE => 34, EREMCHG => 78, EREMOTE => 66, EREMOTEIO => 121, ERESTART => 85,
    EROFS => 30, ESHUTDOWN => 108, ESPIPE => 29, ESOCKTNOSUPPORT => 94, ESRCH => 3,
    ESTALE => 116, ESTRPIPE => 86, ETIME => 62, ETIMEDOUT => 110, ETXTBSY => 26,
    EUCLEAN => 117, EUNATCH => 49, EUSERS => 87, EWOULDBLOCK => 11, EXDEV => 18, EXFULL => 54
);

# --- Expectations for macOS ---
my %darwin_vals = (
    E2BIG => 7, EACCES => 13, EADDRINUSE => 48, EADDRNOTAVAIL => 49, EAFNOSUPPORT => 47,
    EAGAIN => 35, EALREADY => 37, EBADF => 9, EBADMSG => 94, EBUSY => 16, ECANCELED => 89,
    ECHILD => 10, ECONNABORTED => 53, ECONNREFUSED => 61, ECONNRESET => 54, EDEADLK => 11,
    EDESTADDRREQ => 39, EDOM => 33, EDQUOT => 69, EEXIST => 17, EFAULT => 14, EFBIG => 27,
    EHOSTDOWN => 64, EHOSTUNREACH => 65, EIDRM => 90, EILSEQ => 92, EINPROGRESS => 36,
    EINTR => 4, EINVAL => 22, EIO => 5, EISCONN => 56, EISDIR => 21, ELOOP => 62,
    EMFILE => 24, EMLINK => 31, EMSGSIZE => 40, EMULTIHOP => 95, ENAMETOOLONG => 63,
    ENETDOWN => 50, ENETRESET => 52, ENETUNREACH => 51, ENFILE => 23, ENOBUFS => 55,
    ENODEV => 19, ENOENT => 2, ENOEXEC => 8, ENOLCK => 77, ENOLINK => 97, ENOMEM => 12,
    ENOMSG => 91, ENOPROTOOPT => 42, ENOSPC => 28, ENOSR => 98, ENOSTR => 99, ENOSYS => 78,
    ENOTBLK => 15, ENOTCONN => 57, ENOTDIR => 20, ENOTEMPTY => 66, ENOTSOCK => 38,
    ENOTSUP => 45, ENOTTY => 25, ENXIO => 6, EOPNOTSUPP => 102, EOVERFLOW => 84, EPERM => 1,
    EPFNOSUPPORT => 46, EPIPE => 32, EPROTO => 100, EPROTONOSUPPORT => 43, EPROTOTYPE => 41,
    ERANGE => 34, EREMOTE => 71, EROFS => 30, ESHUTDOWN => 58, ESPIPE => 29,
    ESOCKTNOSUPPORT => 44, ESRCH => 3, ESTALE => 70, ETIME => 101, ETIMEDOUT => 60,
    ETXTBSY => 26, EUSERS => 68, EWOULDBLOCK => 35, EXDEV => 18
);

# 1. Strict Validation with Visual Output
my $expected_ref = $is_linux ? \%linux_vals : ($is_darwin ? \%darwin_vals : undef);

if ($expected_ref) {
    subtest "Checking E* constants on $os" => sub {
        for my $name (sort keys %$expected_ref) {
            my $val = eval { SPVM::Errno->$name() };
            if ($@) {
                fail("$os $name: FAILED (Exception thrown)");
                diag("Error message: $@");
            } else {
                is($val, $expected_ref->{$name}, "$os $name: $val");
            }
        }
    };
}

# 2. Windows WSA Constants Check
my @wsa_names = qw(WSAEACCES WSAEADDRINUSE WSAEADDRNOTAVAIL WSAEAFNOSUPPORT WSAEALREADY WSAEBADF WSAECANCELLED WSAECONNABORTED WSAECONNREFUSED WSAECONNRESET WSAEDESTADDRREQ WSAEDISCON WSAEDQUOT WSAEFAULT WSAEHOSTDOWN WSAEHOSTUNREACH WSAEINPROGRESS WSAEINTR WSAEINVAL WSAEINVALIDPROCTABLE WSAEINVALIDPROVIDER WSAEISCONN WSAELOOP WSAEMFILE WSAEMSGSIZE WSAENAMETOOLONG WSAENETDOWN WSAENETRESET WSAENETUNREACH WSAENOBUFS WSAENOMORE WSAENOPROTOOPT WSAENOTCONN WSAENOTEMPTY WSAENOTSOCK WSAEOPNOTSUPP WSAEPFNOSUPPORT WSAEPROCLIM WSAEPROTONOSUPPORT WSAEPROTOTYPE WSAEPROVIDERFAILEDINIT WSAEREFUSED WSAEREMOTE WSAESHUTDOWN WSAESOCKTNOSUPPORT WSAESTALE WSAETIMEDOUT WSAETOOMANYREFS WSAEUSERS WSAEWOULDBLOCK);

subtest "Checking WSA* constants on $os" => sub {
    for my $name (@wsa_names) {
        my $val = eval { SPVM::Errno->$name() };
        my $error = $@;
        if ($is_windows) {
            ok(!$error, "$os $name: $val");
        } else {
            ok($error, "$os $name: Not Supported (Correct)");
        }
    }
};

done_testing;
