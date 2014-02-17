
CC ?= gcc

.for dir in ${INCDIR}
CFLAGS += -I ${dir}
.endfor

.if ${CC:T:Mgcc}
.if !defined(NDEBUG)
CFLAGS += -std=c89 -pedantic
#CFLAGS += -Werror
CFLAGS += -Wall -Wextra -Wno-system-headers
CFLAGS += -ggdb
CFLAGS += -O0 # or -Og if you have it
.else
CFLAGS += -ansi -pedantic
CFLAGS += -O3
.endif
.endif

.if ${CC:T:Mclang}
.if !defined(NDEBUG)
CFLAGS += -std=c89 -pedantic
#CFLAGS += -Werror
CFLAGS += -Weverything -Wno-system-headers
CFLAGS += -Wno-padded # padding is not an error
CFLAGS += -O0
.else
CFLAGS += -ansi -pedantic
CFLAGS += -O4
.endif
.endif

.if !defined(NDEBUG)
CFLAGS += -g
.endif

.for src in ${SRC} ${GEN}

CLEAN += ${BUILD}/${src:R}.o

${BUILD}/${src:R}.o:
	${CC} -o $@ ${CFLAGS} ${CFLAGS_${src}} -c ${.ALLSRC:M*.c}

.endfor

.for src in ${SRC}
${BUILD}/${src:R}.o: ${src}
.endfor

.for src in ${GEN}
${BUILD}/${src:R}.o: ${BUILD}/${src}
.endfor

