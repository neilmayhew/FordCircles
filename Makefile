FONTNAME := Roboto-Medium

FordCircles.svg: FordCircles.hs fonts/$(FONTNAME).svg
	cabal run -- FordCircles -h 900 -o $@

fonts/$(FONTNAME).ttf:
	@echo 'Please download the $(FONTNAME) font from fonts.google.com'
	@echo 'and place it in the fonts subdirectory'
	@false

default.nix: FordCircles.cabal
	cabal2nix . >$@

fonts/%.svg: fonts/%.ttf
	fonts/ttf2svg.sh $<

clean:
	$(RM) FordCircles.svg fonts/$(FONTNAME).svg
	$(RM) -r dist-newstyle
