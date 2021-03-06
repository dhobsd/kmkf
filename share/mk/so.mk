
LD ?= ld
UNAME ?= uname
UNAME_SYSTEM != ${UNAME} -s
SYSTEM ?= ${UNAME_SYSTEM}

.if ${SYSTEM} == Darwin
LIBEXT ?= dylib
.else
LIBEXT ?= so
.endif

.if ${SYSTEM} == Darwin
LDSFLAGS ?= -dynamic -flat_namespace -undefined dynamic_lookup
.else
LDSFLAGS ?= -shared
.endif

.for lib in ${LIB}

lib::    ${BUILD}/lib/${lib}.${LIBEXT}
CLEAN += ${BUILD}/lib/${lib}.${LIBEXT}

${BUILD}/lib/${lib}.${LIBEXT}: ${BUILD}/lib/${lib}.opic
	${LD} -o $@ ${LDSFLAGS} ${.ALLSRC:M*.opic}

STAGE_BUILD += lib/${lib}.${LIBEXT}

.endfor

