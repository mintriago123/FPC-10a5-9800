Name:           libfprint
Version:        1.94.10
Release:        1.lenovo%{?dist}
Summary:        Lenovo OEM libfprint build with proprietary FPC support
License:        Proprietary
BuildArch:      x86_64

Provides:       libfprint = %{version}
Obsoletes:      libfprint
Conflicts:      libfprint

%description
Lenovo OEM build of libfprint including proprietary FPC backend libraries.

%install
mkdir -p %{buildroot}/usr/lib64
mkdir -p %{buildroot}/usr/lib/udev/rules.d

cp %{_sourcedir}/fpc/libfpcbep.so %{buildroot}/usr/lib64/
cp %{_sourcedir}/fpc/libfprint-2.so %{buildroot}/usr/lib64/
cp %{_sourcedir}/fpc/libfprint-2.so.2 %{buildroot}/usr/lib64/
cp %{_sourcedir}/fpc/libfprint-2.so.2.0.0 %{buildroot}/usr/lib64/
cp %{_sourcedir}/fpc/60-libfprint-2-device-fpc.rules %{buildroot}/usr/lib/udev/rules.d/

%files
/usr/lib64/libfpcbep.so
/usr/lib64/libfprint-2.so
/usr/lib64/libfprint-2.so.2
/usr/lib64/libfprint-2.so.2.0.0
/usr/lib/udev/rules.d/60-libfprint-2-device-fpc.rules
