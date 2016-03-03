-include ../mk/platform.mk
-include ../mk/PcapPlusPlus.mk

SOURCES := $(wildcard src/*.cpp)
OBJS_FILENAMES := $(patsubst src/%.cpp,Obj/%.o,$(SOURCES))

ifdef WIN32
DEPS := -DWPCAP -DHAVE_REMOTE
endif
ifdef LINUX
DEPS := -DLINUX
endif
ifdef MAC_OS_X
DEPS := -DMAC_OS_X
endif

ifdef COMPILE_DYNAMIC
DEPS := -DCOMPILE_DYNAMIC
COMPILATION_MODE := dynamic
else
COMPILATION_MODE := static
endif

INCLUDES := -I"./src" \
			-I"./header"
			
ifdef WIN32
INCLUDES += -I$(MINGW_HOME)/include/ddk \
			-I$(WINPCAP_HOME)/Include
endif
ifdef LINUX
INCLUDES += -I/usr/include/netinet
endif
ifdef MAC_OS_X
INCLUDES += -I/usr/include/malloc
endif
		
PCAPPP_EXTERNAL_LIBS := $(patsubst -lPcap++,,$(PCAPPP_LIBS))
PCAPPP_EXTERNAL_LIBS := $(patsubst -lPacket++,,$(PCAPPP_EXTERNAL_LIBS))
PCAPPP_EXTERNAL_LIBS := $(patsubst -lCommon++,,$(PCAPPP_EXTERNAL_LIBS))		
			
Obj/%.o: src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(G++) $(DEPS) $(INCLUDES) -O2 -fPIC -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:Obj/%.o=Obj/%.d)" -MT"$(@:Obj/%.o=Obj/%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


# All Target
all: Common++.$(COMPILATION_MODE)

create-directories:
	$(MKDIR) -p Obj
	$(MKDIR) -p Lib

# Static library compilation
Common++.static: create-directories $(OBJS_FILENAMES)
	@echo 'Building staic target: $@'
	@echo 'Invoking: GCC Archiver'
	$(AR) -r "Lib/$(LIB_PREFIX)Common++$(STAT_LIB_EXT)" $(OBJS_FILENAMES)
	@echo 'Finished successfully building static target: $@'
	@echo ' '


# Dynamic library compilation
Common++.dynamic: create-directories $(OBJS_FILENAMES)
	@echo 'Building dynamic target: $@'
	@echo 'Invoking: GCC'
	$(G++) -shared -Wl,-soname,$(LIB_PREFIX)Common++$(DYN_LIB_EXT) $(PCAPPP_LIBS_DIR) -o "Lib/$(LIB_PREFIX)Common++$(DYN_LIB_EXT)" $(OBJS_FILENAMES) $(PCAPPP_EXTERNAL_LIBS)
	@echo 'Finished successfully building dynamic target: $@'
	@echo ' '


# Clean Target
clean:
	$(RM) -rf ./Obj/*
	$(RM) -rf ./Lib/*
	@echo 'Clean finished'