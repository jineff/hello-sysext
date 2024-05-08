arch			:= x86-64
extension_dir	:= /var/lib/extensions
output_dir		:= ./output
v1				:= hello-1.0
sysext-v1		:= $(v1)-$(arch).raw
v2				:= hello-2.0
sysext-v2		:= $(v2)-$(arch).raw

build-v1: $(output_dir)/$(sysext-v1)

$(output_dir)/$(sysext-v1): $(shell find $(v1) -type f)
	mksquashfs $(v1) $@ -all-root -noappend

install-v1: $(output_dir)/$(sysext-v1)
	sudo install -D -m 644 $< $(extension_dir)

build-v2: $(output_dir)/$(sysext-v2)

$(output_dir)/$(sysext-v2): $(shell find $(v2) -type f)
	mksquashfs $(v2) $@ -all-root -noappend

serve:
	python3 -m http.server -d $(output_dir) 8080

merge:
	sudo systemd-sysext merge

unmerge: 
	sudo systemd-sysext unmerge

debug:
	systemd-sysext list
	sudo systemd-sysext status

clean:
	rm -f $(output_dir)/*

distclean: clean
	sudo rm -i $(extension_dir)/*
