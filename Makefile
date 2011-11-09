CC	=	g++
# debug version
#CFLAGS  = -Wall -ggdb
# release version:
CFLAGS	=	-O3 -ffast-math -fomit-frame-pointer

PATH_BIN = ./bin

########################################################################################################
# muParser library sources
PATH_LIB = parser
PATH_OBJ = obj
LIB_SRC = mpError.cpp mpRPN.cpp mpICallback.cpp mpIValReader.cpp mpParserBase.cpp mpTokenReader.cpp\
          mpVariable.cpp mpIOprt.cpp mpIValue.cpp mpParser.cpp mpValReader.cpp mpFuncStr.cpp\
		  mpFuncCommon.cpp mpFuncNonCmplx.cpp mpFuncCmplx.cpp mpIToken.cpp mpOprtCmplx.cpp \
		  mpOprtNonCmplx.cpp mpOprtBinCommon.cpp mpOprtBinAssign.cpp mpOprtMatrix.cpp\
          mpIPackage.cpp mpPackageCommon.cpp mpPackageStr.cpp mpPackageCmplx.cpp mpPackageNonCmplx.cpp\
          mpPackageMatrix.cpp mpPackageUnit.cpp mpIfThenElse.cpp mpValueCache.cpp mpValue.cpp mpTest.cpp\
		  mpScriptTokens.cpp mpFuncMatrix.cpp mpOprtIndex.cpp
LIB_OBJ = ${LIB_SRC:.cpp=.o}
NAME_LIB = bin/libmuparserx.a
EXAMPLE_PATH=bin/example

########################################################################################################
# example application
PATH_SAMPLE = sample

all:	$(EXAMPLE_PATH)

new:  clean $(EXAMPLE_PATH)

#$(LIB_OBJ)
$(NAME_LIB): $(LIB_OBJ:%.o=$(PATH_OBJ)/%.o)
	@echo ""
	@echo "#########################################################"
	@echo "#                                                       #"
	@echo "#   Building libmuparserX                               #"
	@echo "#                                                       #"
	@echo "#########################################################"
	@echo ""

	ar ru $(NAME_LIB) $(LIB_OBJ:%.o=$(PATH_OBJ)/%.o)
	ranlib $(NAME_LIB)

#$(LIB_OBJ):
$(LIB_OBJ:%.o=$(PATH_OBJ)/%.o):
	$(CC) $(CFLAGS) -c $(subst $(PATH_OBJ),$(PATH_LIB),${@:.o=.cpp}) -o $@

#$(CC) $(CFLAGS) -c ${@:.o=.cpp} -o $@

$(EXAMPLE_PATH): $(NAME_LIB)
	@echo ""
	@echo "#########################################################"
	@echo "#                                                       #"
	@echo "#   Building sample                                     #"
	@echo "#                                                       #"
	@echo "#########################################################"
	@echo ""
	$(CC) $(CFLAGS) -I$(PATH_LIB) -L$(PATH_BIN) -o $@ $(PATH_SAMPLE)/example.cpp $(PATH_SAMPLE)/timer.cpp -lmuparserx -lm

clean:
	@echo "########################################################"
	@echo "#                                                      #"
	@echo "#  Cleaning up                                         #"
	@echo "#                                                      #"
	@echo "########################################################"
	@echo ""
	rm -rf *.o
	rm -rf *~
	rm -rf $(PATH_OBJ)/*
	rm -rf $(PATH_BIN)/*

new:
	$(MAKE) clean
	$(MAKE) all
