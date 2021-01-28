OBJS += src/common/memory.o
OBJS += src/common/core/log.o
OBJS += src/common/core/dvb_text.o
OBJS += src/common/dvb/dvb.o
OBJS += src/common/opentv/opentv.o
OBJS += src/common/opentv/huffman.o
OBJS += src/common/providers/providers.o
OBJS += src/common/epgdb/epgdb.o
OBJS += src/common/epgdb/epgdb_channels.o
OBJS += src/common/epgdb/epgdb_titles.o

DOWNLOADER_OBJS += src/common/OpenTVdecoder.o

DOWNLOADER_BIN = bin/OpenTVdecoder

BIN_DIR = bin

#CFLAGS += -g -Wall -Werror

all: clean $(DOWNLOADER_BIN)

$(BIN_DIR):
	mkdir -p $@

$(OBJS): $(BIN_DIR)
	$(CC) $(CFLAGS) -c -fpic -o $@ $(@:.o=.c)

$(DOWNLOADER_OBJS):
	$(CC) $(CFLAGS) -c -o $@ $(@:.o=.c)

$(DOWNLOADER_BIN): $(OBJS) $(DOWNLOADER_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(DOWNLOADER_OBJS)
	$(STRIP) $@

clean:
	rm -f $(OBJS) $(DOWNLOADER_OBJS) $(DOWNLOADER_BIN)

install-standalone:
	install -d $(D)/opt/OpenTVdecoder/providers
	install -m 755 bin/OpenTVdecoder $(D)/opt/OpenTVdecoder/
	install -m 644 providers/* $(D)/opt/OpenTVdecoder/providers/

install-standalone-var:
	install -d $(D)/var/OpenTVdecoder/providers
	install -m 755 bin/OpenTVdecoder $(D)/var/OpenTVdecoder/
	install -m 644 providers/* $(D)/var/OpenTVdecoder/providers/

install: install-standalone
install-var: install-standalone-var

