use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Fn';
use SPVM::Errno;

use SPVM 'TestCase::Errno';

use SPVM 'Errno';

use Errno();

sub errno_ok {
  my ($errno_func_name) = @_;
  
  my (undef, $file, $line) = caller;
  
  my $errno_perl_func = "Errno::$errno_func_name";
  
  my $match;
  eval { SPVM::Errno->$errno_func_name };
  if ($@) {
    warn "\"$errno_func_name\" is not supported on this system";
  }
  else {
    no strict 'refs';
    my $errno = SPVM::Errno->$errno_func_name;
    my $errno_expected = &$errno_perl_func;
    is($errno, $errno_expected);
    warn "$errno_func_name: $errno";
  }
}

ok(SPVM::TestCase::Errno->errno);

ok(SPVM::TestCase::Errno->set_errno);

{
  {
    SPVM::Errno->set_errno(Errno->EINVAL);
    
    $! = Errno->EINVAL;
    
    my $strerror = SPVM::Errno->strerror(Errno->EINVAL);
    
    warn "[Test Output]strerror:$strerror";
    is($strerror, "$!");
  }
}

{
  errno_ok('E2BIG');
}
{
  errno_ok('EACCES');
}
{
  errno_ok('EADDRINUSE');
}
{
  errno_ok('EADDRNOTAVAIL');
}
{
  errno_ok('EAFNOSUPPORT');
}
{
  errno_ok('EAGAIN');
}
{
  errno_ok('EALREADY');
}
{
  errno_ok('EBADE');
}
{
  errno_ok('EBADF');
}
{
  errno_ok('EBADFD');
}
{
  errno_ok('EBADMSG');
}
{
  errno_ok('EBADR');
}
{
  errno_ok('EBADRQC');
}
{
  errno_ok('EBADSLT');
}
{
  errno_ok('EBUSY');
}
{
  errno_ok('ECANCELED');
}
{
  errno_ok('ECHILD');
}
{
  errno_ok('ECHRNG');
}
{
  errno_ok('ECOMM');
}
{
  errno_ok('ECONNABORTED');
}
{
  errno_ok('ECONNREFUSED');
}
{
  errno_ok('ECONNRESET');
}
{
  errno_ok('EDEADLK');
}
{
  errno_ok('EDEADLOCK');
}
{
  errno_ok('EDESTADDRREQ');
}
{
  errno_ok('EDOM');
}
{
  errno_ok('EDQUOT');
}
{
  errno_ok('EEXIST');
}
{
  errno_ok('EFAULT');
}
{
  errno_ok('EFBIG');
}
{
  errno_ok('EHOSTDOWN');
}
{
  errno_ok('EHOSTUNREACH');
}
{
  errno_ok('EIDRM');
}
{
  errno_ok('EILSEQ');
}
{
  errno_ok('EINPROGRESS');
}
{
  errno_ok('EINTR');
}
{
  errno_ok('EINVAL');
}
{
  errno_ok('EIO');
}
{
  errno_ok('EISCONN');
}
{
  errno_ok('EISDIR');
}
{
  errno_ok('EISNAM');
}
{
  errno_ok('EKEYEXPIRED');
}
{
  errno_ok('EKEYREJECTED');
}
{
  errno_ok('EKEYREVOKED');
}
{
  errno_ok('EL2HLT');
}
{
  errno_ok('EL2NSYNC');
}
{
  errno_ok('EL3HLT');
}
{
  errno_ok('EL3RST');
}
{
  errno_ok('ELIBACC');
}
{
  errno_ok('ELIBBAD');
}
{
  errno_ok('ELIBMAX');
}
{
  errno_ok('ELIBSCN');
}
{
  errno_ok('ELIBEXEC');
}
{
  errno_ok('ELOOP');
}
{
  errno_ok('EMEDIUMTYPE');
}
{
  errno_ok('EMFILE');
}
{
  errno_ok('EMLINK');
}
{
  errno_ok('EMSGSIZE');
}
{
  errno_ok('EMULTIHOP');
}
{
  errno_ok('ENAMETOOLONG');
}
{
  errno_ok('ENETDOWN');
}
{
  errno_ok('ENETRESET');
}
{
  errno_ok('ENETUNREACH');
}
{
  errno_ok('ENFILE');
}
{
  errno_ok('ENOBUFS');
}
{
  errno_ok('ENODATA');
}
{
  errno_ok('ENODEV');
}
{
  errno_ok('ENOENT');
}
{
  errno_ok('ENOEXEC');
}
{
  errno_ok('ENOKEY');
}
{
  errno_ok('ENOLCK');
}
{
  errno_ok('ENOLINK');
}
{
  errno_ok('ENOMEDIUM');
}
{
  errno_ok('ENOMEM');
}
{
  errno_ok('ENOMSG');
}
{
  errno_ok('ENONET');
}
{
  errno_ok('ENOPKG');
}
{
  errno_ok('ENOPROTOOPT');
}
{
  errno_ok('ENOSPC');
}
{
  errno_ok('ENOSR');
}
{
  errno_ok('ENOSTR');
}
{
  errno_ok('ENOSYS');
}
{
  errno_ok('ENOTBLK');
}
{
  errno_ok('ENOTCONN');
}
{
  errno_ok('ENOTDIR');
}
{
  errno_ok('ENOTEMPTY');
}
{
  errno_ok('ENOTSOCK');
}
{
  errno_ok('ENOTSUP');
}
{
  errno_ok('ENOTTY');
}
{
  errno_ok('ENOTUNIQ');
}
{
  errno_ok('ENXIO');
}
{
  errno_ok('EOPNOTSUPP');
}
{
  errno_ok('EOVERFLOW');
}
{
  errno_ok('EPERM');
}
{
  errno_ok('EPFNOSUPPORT');
}
{
  errno_ok('EPIPE');
}
{
  errno_ok('EPROTO');
}
{
  errno_ok('EPROTONOSUPPORT');
}
{
  errno_ok('EPROTOTYPE');
}
{
  errno_ok('ERANGE');
}
{
  errno_ok('EREMCHG');
}
{
  errno_ok('EREMOTE');
}
{
  errno_ok('EREMOTEIO');
}
{
  errno_ok('ERESTART');
}
{
  errno_ok('EROFS');
}
{
  errno_ok('ESHUTDOWN');
}
{
  errno_ok('ESPIPE');
}
{
  errno_ok('ESOCKTNOSUPPORT');
}
{
  errno_ok('ESRCH');
}
{
  errno_ok('ESTALE');
}
{
  errno_ok('ESTRPIPE');
}
{
  errno_ok('ETIME');
}
{
  errno_ok('ETIMEDOUT');
}
{
  errno_ok('ETXTBSY');
}
{
  errno_ok('EUCLEAN');
}
{
  errno_ok('EUNATCH');
}
{
  errno_ok('EUSERS');
}
{
  errno_ok('EWOULDBLOCK');
}
{
  errno_ok('EXDEV');
}
{
  errno_ok('EXFULL');
}

errno_ok('WSAEACCES');
errno_ok('WSAEADDRINUSE');
errno_ok('WSAEADDRNOTAVAIL');
errno_ok('WSAEAFNOSUPPORT');
errno_ok('WSAEALREADY');
errno_ok('WSAEBADF');
errno_ok('WSAECANCELLED');
errno_ok('WSAECONNABORTED');
errno_ok('WSAECONNREFUSED');
errno_ok('WSAECONNRESET');
errno_ok('WSAEDESTADDRREQ');
errno_ok('WSAEDISCON');
errno_ok('WSAEDQUOT');
errno_ok('WSAEFAULT');
errno_ok('WSAEHOSTDOWN');
errno_ok('WSAEHOSTUNREACH');
errno_ok('WSAEINPROGRESS');
errno_ok('WSAEINTR');
errno_ok('WSAEINVAL');
errno_ok('WSAEINVALIDPROCTABLE');
errno_ok('WSAEINVALIDPROVIDER');
errno_ok('WSAEISCONN');
errno_ok('WSAELOOP');
errno_ok('WSAEMFILE');
errno_ok('WSAEMSGSIZE');
errno_ok('WSAENAMETOOLONG');
errno_ok('WSAENETDOWN');
errno_ok('WSAENETRESET');
errno_ok('WSAENETUNREACH');
errno_ok('WSAENOBUFS');
errno_ok('WSAENOMORE');
errno_ok('WSAENOPROTOOPT');
errno_ok('WSAENOTCONN');
errno_ok('WSAENOTEMPTY');
errno_ok('WSAENOTSOCK');
errno_ok('WSAEOPNOTSUPP');
errno_ok('WSAEPFNOSUPPORT');
errno_ok('WSAEPROCLIM');
errno_ok('WSAEPROTONOSUPPORT');
errno_ok('WSAEPROTOTYPE');
errno_ok('WSAEPROVIDERFAILEDINIT');
errno_ok('WSAEREFUSED');
errno_ok('WSAEREMOTE');
errno_ok('WSAESHUTDOWN');
errno_ok('WSAESOCKTNOSUPPORT');
errno_ok('WSAESTALE');
errno_ok('WSAETIMEDOUT');
errno_ok('WSAETOOMANYREFS');
errno_ok('WSAEUSERS');
errno_ok('WSAEWOULDBLOCK');

# Version
is($SPVM::Errno::VERSION, SPVM::Fn->get_version_string('Errno'));

done_testing;
