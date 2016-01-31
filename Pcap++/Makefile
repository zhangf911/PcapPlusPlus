-include ../mk/platform.mk
-include ../mk/PcapPlusPlus.mk

SOURCES := $(wildcard src/*.cpp)
OBJS_FILENAMES := $(patsubst src/%.cpp,Obj/%.o,$(SOURCES))

COMMONPP_HOME := ../Common++
PACKETPP_HOME := ../Packet++

ifdef WIN32
DEPS := -DWPCAP -DHAVE_REMOTE
endif
ifdef LINUX
DEPS := -DLINUX
endif
ifdef PF_RING_HOME
DEPS += -DUSE_PF_RING
endif
ifdef USE_DPDK
DEPS += -DUSE_DPDK
endif
ifdef MAC_OS_X
DEPS := -DMAC_OS_X
endif

INCLUDES := -I"./src" \
			-I"./header" \
			-I"$(COMMONPP_HOME)/header" \
			-I"$(PACKETPP_HOME)/header"

PCAPPP_EXTERNAL_LIBS := $(patsubst -lPcap++,,$(PCAPPP_LIBS))
PCAPPP_EXTERNAL_LIBS := $(patsubst -lPacket++,,$(PCAPPP_EXTERNAL_LIBS))
PCAPPP_EXTERNAL_LIBS := $(patsubst -lCommon++,,$(PCAPPP_EXTERNAL_LIBS))
			
ifdef WIN32
INCLUDES += -I$(MINGW_HOME)/include/ddk \
			-I$(WINPCAP_HOME)/Include
endif
ifdef LINUX
INCLUDES += -I/usr/include/netinet
endif
ifdef PF_RING_HOME
INCLUDES += -I$(PF_RING_HOME)/userland/lib -I$(PF_RING_HOME)/kernel
endif
ifdef USE_DPDK
INCLUDES += -I"$(RTE_SDK)/$(RTE_TARGET)/include"
endif

ifdef USE_DPDK
FLAGS := -msse -msse2 -msse3 -mssse3
endif		
	
Obj/%.o: src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(G++) $(DEPS) $(INCLUDES) $(FLAGS) -O2 -fPIC -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:Obj/%.o=Obj/%.d)" -MT"$(@:Obj/%.o=Obj/%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

# All Target
all: Pcap++.static Pcap++.dynamic

create-directories:
	$(MKDIR) -p Obj
	$(MKDIR) -p Lib

# Static library compilation
Pcap++.static: create-directories $(OBJS_FILENAMES)
	@echo 'Building static target: $@'
	@echo 'Invoking: GCC Archiver'
	$(AR) -r  "Lib/$(LIB_PREFIX)Pcap++$(STAT_LIB_EXT)" $(OBJS_FILENAMES)
	@echo 'Finished successfully building static target: $@'
	@echo ' '

# Dymnamic library compilation	
Pcap++.dynamic: create-directories $(OBJS_FILENAMES)
	@echo 'Building dynamic target: $@'
	@echo 'Invoking: GCC'
	$(G++) -shared -Wl,-soname,$(LIB_PREFIX)Pcap++$(DYN_LIB_EXT) $(PCAPPP_LIBS_DIR) -o "Lib/$(LIB_PREFIX)Pcap++$(DYN_LIB_EXT)" $(OBJS_FILENAMES) $(PACKETPP_HOME)/Lib/$(LIB_PREFIX)Packet++$(STAT_LIB_EXT) $(COMMONPP_HOME)/Lib/$(LIB_PREFIX)Common++$(STAT_LIB_EXT) $(PCAPPP_EXTERNAL_LIBS) 
	@echo 'Finished successfully building dynamic target: $@'
	@echo ' '

# Clean Target
clean:
	$(RM) -rf ./Obj/*
	$(RM) -rf ./Lib/*
	@echo 'Clean finished'
