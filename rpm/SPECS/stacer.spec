Name:           stacer
Version:        1.3.5
Release:        1%{?dist}
Summary:        Linux system optimizer and monitoring

License:        GPLv3
URL:            https://stacer.quentium.fr/
Source0:        %{name}-%{version}.tar.gz

BuildArch:      x86_64
Requires:       qt6-qtbase qt6-qtcharts qt6-qtsvg qt6-qtbase-gui glibc systemd curl

%description
Monitor your system (CPU, memory, disk) in a graphical application (Qt).
Change and monitor your services. Summarizes basic system information and
can show network download/upload speeds/totals.

%prep
%setup -q

%build
echo "No build step defined"

%install
rm -rf %{buildroot}

# Install binary
install -Dm755 %{_builddir}/release/%{name}-%{version}/stacer/stacer %{buildroot}/usr/bin/stacer

# Install .desktop file
install -Dm644 %{_builddir}/release/%{name}-%{version}/applications/stacer.desktop %{buildroot}/usr/share/applications/stacer.desktop

# Install icon sizes
for size in 16 32 64 128 256; do
    install -Dm644 %{_builddir}/release/%{name}-%{version}/icons/hicolor/${size}x${size}/apps/stacer.png \
        %{buildroot}/usr/share/icons/hicolor/${size}x${size}/apps/stacer.png
done

# Install README doc
install -Dm644 %{_builddir}/README.md %{buildroot}/usr/share/doc/stacer/README.md

%files
%license
%doc
/usr/bin/stacer
/usr/share/applications/stacer.desktop
/usr/share/icons/hicolor/*/apps/stacer.png
/usr/share/doc/stacer/README.md

%changelog
