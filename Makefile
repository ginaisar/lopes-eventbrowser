#############################################################################
# Makefile for building: browser
# Generated by qmake (1.07a) (Qt 3.3.7) on: Mon Jun 30 10:57:35 2008
# Project:  browser.pro
# Template: app
# Command: $(QMAKE) -o Makefile browser.pro
#############################################################################

####### Compiler, tools and options

CC       = gcc
CXX      = g++
LEX      = flex
YACC     = yacc
CFLAGS   = -pipe -O2 -march=i586 -mtune=i686 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -g -fno-strict-aliasing -Wall -W -O2 -march=i586 -mtune=i686 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -g -fno-strict-aliasing  -DDEBUG -DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
CXXFLAGS = -pipe -O2 -march=i586 -mtune=i686 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -g -fno-strict-aliasing -Wall -W -O2 -march=i586 -mtune=i686 -fmessage-length=0 -Wall -D_FORTIFY_SOURCE=2 -g -fno-strict-aliasing  -DDEBUG -DQT_NO_DEBUG -DQT_SHARED -DQT_THREAD_SUPPORT
LEXFLAGS = 
YACCFLAGS= -d
INCPATH  = -I/usr/lib/qt3/mkspecs/default -I. -I. -Ibuild -ImuParserLib -I"$(ROOTSYS)/include" -I/usr/include -I$(QTDIR)/include -Ibuild/ -Iforms -Ibuild/
LINK     = g++
LFLAGS   = 
LIBS     = $(SUBLIBS) -L/usr/lib/ -L$(QTDIR)/lib/ -L/usr/X11R6/lib/ -L$(ROOTSYS)/lib -L/tmp/root/lib -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -lGui -pthread -ldl -rdynamic -lTable -lGQt -lqt-mt -lXext -lX11 -lm
AR       = ar cqs
RANLIB   = 
MOC      = $(QTDIR)/bin/moc
UIC      = $(QTDIR)/bin/uic
QMAKE    = qmake
TAR      = tar -cf
GZIP     = gzip -9f
COPY     = cp -f
COPY_FILE= $(COPY)
COPY_DIR = $(COPY) -r
INSTALL_FILE= $(COPY_FILE)
INSTALL_DIR = $(COPY_DIR)
DEL_FILE = rm -f
SYMLINK  = ln -sf
DEL_DIR  = rmdir
MOVE     = mv -f
CHK_DIR_EXISTS= test -d
MKDIR    = mkdir -p

####### Output directory

OBJECTS_DIR = build/

####### Files

HEADERS = forms/mainform.ui.h \
		Draw.h \
		ReadRootTree.h \
		Canvas.h \
		Helper.h \
		forms/formviewdata.ui.h
SOURCES = main.cpp \
		Draw.cpp \
		ReadRootTree.cpp \
		Canvas.cpp \
		Helper.cpp \
		muParserLib/muParserBase.cpp \
		muParserLib/muParser.cpp \
		muParserLib/muParserBytecode.cpp \
		muParserLib/muParserCallback.cpp \
		muParserLib/muParserError.cpp \
		muParserLib/muParserTokenReader.cpp
OBJECTS = build/main.o \
		build/Draw.o \
		build/ReadRootTree.o \
		build/Canvas.o \
		build/Helper.o \
		build/muParserBase.o \
		build/muParser.o \
		build/muParserBytecode.o \
		build/muParserCallback.o \
		build/muParserError.o \
		build/muParserTokenReader.o \
		build/mainform.o \
		build/formviewdata.o
FORMS = forms/mainform.ui \
		forms/formviewdata.ui
UICDECLS = build/mainform.h \
		build/formviewdata.h
UICIMPLS = build/mainform.cpp \
		build/formviewdata.cpp
SRCMOC   = build/moc_mainform.cpp \
		build/moc_formviewdata.cpp
OBJMOC = build/moc_mainform.o \
		build/moc_formviewdata.o
DIST	   = /tmp/root/include/rootlibs.pri \
		/tmp/root/include/rootcintrule.pri \
		/tmp/root/include/rootcint.pri \
		browser.pro
QMAKE_TARGET = browser
DESTDIR  = 
TARGET   = browser

first: all
####### Implicit rules

.SUFFIXES: .c .o .cpp .cc .cxx .C

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.C.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o $@ $<

.c.o:
	$(CC) -c $(CFLAGS) $(INCPATH) -o $@ $<

####### Build rules

all: Makefile $(TARGET)

$(TARGET):  $(UICDECLS) $(OBJECTS) $(OBJMOC)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJMOC) $(OBJCOMP) $(LIBS)

mocables: $(SRCMOC)
uicables: $(UICDECLS) $(UICIMPLS)

$(MOC): 
	( cd $(QTDIR)/src/moc && $(MAKE) )

Makefile: browser.pro  /usr/lib/qt3/mkspecs/default/qmake.conf /tmp/root/include/rootlibs.pri \
		/tmp/root/include/rootcintrule.pri \
		/tmp/root/include/rootcint.pri \
		/usr/lib/qt3/lib/libqt-mt.prl
	$(QMAKE) -o Makefile browser.pro
qmake: 
	@$(QMAKE) -o Makefile browser.pro

dist: 
	@mkdir -p build/browser && $(COPY_FILE) --parents $(SOURCES) $(HEADERS) $(FORMS) $(DIST) build/browser/ && $(COPY_FILE) --parents forms/mainform.ui.h forms/formviewdata.ui.h build/browser/ && ( cd `dirname build/browser` && $(TAR) browser.tar browser && $(GZIP) browser.tar ) && $(MOVE) `dirname build/browser`/browser.tar.gz . && $(DEL_FILE) -r build/browser

mocclean:
	-$(DEL_FILE) $(OBJMOC)
	-$(DEL_FILE) $(SRCMOC)

uiclean:
	-$(DEL_FILE) $(UICIMPLS) $(UICDECLS)

yaccclean:
lexclean:
clean: mocclean uiclean
	-$(DEL_FILE) $(OBJECTS)
	-$(DEL_FILE) *~ core *.core


####### Sub-libraries

distclean: clean
	-$(DEL_FILE) $(TARGET) $(TARGET)


FORCE:

####### Compile

build/main.o: main.cpp build/mainform.h \
		ReadRootTree.h \
		Helper.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TObjString.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/main.o main.cpp

build/Draw.o: Draw.cpp Draw.h \
		$(ROOTSYS)/include/TGraph.h \
		$(ROOTSYS)/include/TGraphErrors.h \
		$(ROOTSYS)/include/TGraphPolar.h \
		$(ROOTSYS)/include/TCanvas.h \
		$(ROOTSYS)/include/TAxis.h \
		$(ROOTSYS)/include/TMarker.h \
		$(ROOTSYS)/include/TStyle.h \
		$(ROOTSYS)/include/TLegend.h \
		ReadRootTree.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TVectorFfwd.h \
		$(ROOTSYS)/include/TVectorDfwd.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TAttText.h \
		$(ROOTSYS)/include/TPad.h \
		$(ROOTSYS)/include/TAttCanvas.h \
		$(ROOTSYS)/include/TVirtualX.h \
		$(ROOTSYS)/include/TCanvasImp.h \
		$(ROOTSYS)/include/TVirtualPad.h \
		$(ROOTSYS)/include/TAttPad.h \
		$(ROOTSYS)/include/Buttons.h \
		$(ROOTSYS)/include/TQObject.h \
		$(ROOTSYS)/include/GuiTypes.h \
		$(ROOTSYS)/include/TQClass.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TObjString.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TAttAxis.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TPave.h \
		$(ROOTSYS)/include/TBox.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/Draw.o Draw.cpp

build/ReadRootTree.o: ReadRootTree.cpp ReadRootTree.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TObjString.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/ReadRootTree.o ReadRootTree.cpp

build/Canvas.o: Canvas.cpp Canvas.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/Canvas.o Canvas.cpp

build/Helper.o: Helper.cpp Helper.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/Helper.o Helper.cpp

build/muParserBase.o: muParserLib/muParserBase.cpp muParserLib/muParser.h \
		muParserLib/muParserBase.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserStack.h \
		muParserLib/muParserTokenReader.h \
		muParserLib/muParserBytecode.h \
		muParserLib/muParserError.h \
		muParserLib/muParserFixes.h \
		muParserLib/muParserToken.h \
		muParserLib/muParserCallback.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParserBase.o muParserLib/muParserBase.cpp

build/muParser.o: muParserLib/muParser.cpp muParserLib/muParser.h \
		muParserLib/muParserBase.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserStack.h \
		muParserLib/muParserTokenReader.h \
		muParserLib/muParserBytecode.h \
		muParserLib/muParserError.h \
		muParserLib/muParserFixes.h \
		muParserLib/muParserToken.h \
		muParserLib/muParserCallback.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParser.o muParserLib/muParser.cpp

build/muParserBytecode.o: muParserLib/muParserBytecode.cpp muParserLib/muParserBytecode.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserError.h \
		muParserLib/muParserToken.h \
		muParserLib/muParserFixes.h \
		muParserLib/muParserCallback.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParserBytecode.o muParserLib/muParserBytecode.cpp

build/muParserCallback.o: muParserLib/muParserCallback.cpp muParserLib/muParserCallback.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserFixes.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParserCallback.o muParserLib/muParserCallback.cpp

build/muParserError.o: muParserLib/muParserError.cpp muParserLib/muParserError.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserFixes.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParserError.o muParserLib/muParserError.cpp

build/muParserTokenReader.o: muParserLib/muParserTokenReader.cpp muParserLib/muParserTokenReader.h \
		muParserLib/muParserBase.h \
		muParserLib/muParserDef.h \
		muParserLib/muParserToken.h \
		muParserLib/muParserFixes.h \
		muParserLib/muParserError.h \
		muParserLib/muParserCallback.h \
		muParserLib/muParserStack.h \
		muParserLib/muParserBytecode.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/muParserTokenReader.o muParserLib/muParserTokenReader.cpp

build/mainform.h: forms/mainform.ui 
	$(UIC) forms/mainform.ui -o build/mainform.h

build/mainform.cpp: build/mainform.h forms/mainform.ui forms/mainform.ui.h 
	$(UIC) forms/mainform.ui -i mainform.h -o build/mainform.cpp

build/formviewdata.h: forms/formviewdata.ui ReadRootTree.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TObjString.h
	$(UIC) forms/formviewdata.ui -o build/formviewdata.h

build/formviewdata.cpp: build/formviewdata.h forms/formviewdata.ui forms/formviewdata.ui.h ReadRootTree.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TObjString.h
	$(UIC) forms/formviewdata.ui -i formviewdata.h -o build/formviewdata.cpp

build/mainform.o: build/mainform.cpp forms/mainform.ui.h \
		build/mainform.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/mainform.o build/mainform.cpp

build/formviewdata.o: build/formviewdata.cpp build/formviewdata.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/formviewdata.o build/formviewdata.cpp

build/moc_mainform.o: build/moc_mainform.cpp  build/mainform.h 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/moc_mainform.o build/moc_mainform.cpp

build/moc_formviewdata.o: build/moc_formviewdata.cpp  build/formviewdata.h ReadRootTree.h \
		$(ROOTSYS)/include/TFile.h \
		$(ROOTSYS)/include/TTree.h \
		$(ROOTSYS)/include/TEventList.h \
		$(ROOTSYS)/include/TChain.h \
		$(ROOTSYS)/include/TMath.h \
		$(ROOTSYS)/include/TDirectoryFile.h \
		$(ROOTSYS)/include/TUrl.h \
		$(ROOTSYS)/include/TDirectory.h \
		$(ROOTSYS)/include/TNamed.h \
		$(ROOTSYS)/include/TList.h \
		$(ROOTSYS)/include/TDatime.h \
		$(ROOTSYS)/include/TUUID.h \
		$(ROOTSYS)/include/TObject.h \
		$(ROOTSYS)/include/TString.h \
		$(ROOTSYS)/include/Rtypes.h \
		$(ROOTSYS)/include/TStorage.h \
		$(ROOTSYS)/include/TVersionCheck.h \
		$(ROOTSYS)/include/Riosfwd.h \
		$(ROOTSYS)/include/TBuffer.h \
		$(ROOTSYS)/include/RConfig.h \
		$(ROOTSYS)/include/DllImport.h \
		$(ROOTSYS)/include/Rtypeinfo.h \
		$(ROOTSYS)/include/TGenericClassInfo.h \
		$(ROOTSYS)/include/RVersion.h \
		$(ROOTSYS)/include/TRefCnt.h \
		$(ROOTSYS)/include/TMathBase.h \
		$(ROOTSYS)/include/TSeqCollection.h \
		$(ROOTSYS)/include/TCollection.h \
		$(ROOTSYS)/include/TIterator.h \
		$(ROOTSYS)/include/TBranch.h \
		$(ROOTSYS)/include/TObjArray.h \
		$(ROOTSYS)/include/TAttLine.h \
		$(ROOTSYS)/include/TAttFill.h \
		$(ROOTSYS)/include/TAttMarker.h \
		$(ROOTSYS)/include/TArrayD.h \
		$(ROOTSYS)/include/TArrayI.h \
		$(ROOTSYS)/include/TDataType.h \
		$(ROOTSYS)/include/TClass.h \
		$(ROOTSYS)/include/TVirtualTreePlayer.h \
		$(ROOTSYS)/include/TArray.h \
		$(ROOTSYS)/include/TDictionary.h \
		$(ROOTSYS)/include/Property.h \
		$(ROOTSYS)/include/TObjString.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o build/moc_formviewdata.o build/moc_formviewdata.cpp

build/moc_mainform.cpp: $(MOC) build/mainform.h
	$(MOC) build/mainform.h -o build/moc_mainform.cpp

build/moc_formviewdata.cpp: $(MOC) build/formviewdata.h
	$(MOC) build/formviewdata.h -o build/moc_formviewdata.cpp

####### Install

install:  

uninstall:  

