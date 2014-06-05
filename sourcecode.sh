#!/bin/bash

# sourcecode generator for latex
# generates specific methods from a file into our sourcecode file

files=('foobar.java')
methods=('someMethod')

for i in $(seq 0 $((${#files[*]}-1))); do
    METHOD=${methods[$i]}
    FILE=${files[$i]}
    PACKAGE=$(grep package ${FILE} | awk '{print $2}' | tr -d ';')
    NAME=$(basename $(basename ${FILE}) .java)
    echo $PACKAGE
    echo $NAME
    echo $METHOD
    echo $FILE
    echo "\\begin{lstlisting}[language=Java,caption="${PACKAGE}.${NAME}.${METHOD}",label={lst:${METHOD}}]" >> chapters/sourcecode.tex
    
    #[caption="${PACKAGE}.${NAME} ${METHOD}",language=Java]{
    python parsecode.py --file $FILE --method $METHOD >> chapters/sourcecode.tex

    echo "\\end{lstlisting}" >> chapters/sourcecode.tex
done

