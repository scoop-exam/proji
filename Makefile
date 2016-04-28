MAIN=problem
EIFFEL_DIR=${MAIN}/src/e

all: eiffel

eiffel:
ifdef FREEZE
	cd ${EIFFEL_DIR} && ec -freeze -config ${MAIN}.ecf
else
	cd ${EIFFEL_DIR} && ec -config ${MAIN}.ecf
endif
	cd ${EIFFEL_DIR}/EIFGENs/${MAIN}/W_code; finish_freezing
	cp ${EIFFEL_DIR}/EIFGENs/${MAIN}/W_code/${MAIN} ./${MAIN}.out

clean:
	cd ${EIFFEL_DIR} && ec -clean -config ${MAIN}.ecf

