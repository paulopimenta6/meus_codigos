#!/bin/bash

#Programa para baixar arquivos grib

#Diretorios
dir="/media/utrecht/12382BE468602ECF/goGrib/"
#Datas
data_ano=`date +"%Y"`
data_mes=`date +"%m"`
data_dia=`date +"%d"`
data_completa="${data_ano}""${data_mes}""${data_dia}"
hora00grib="00"
hora06grib="06"
hora12grib="12"
hora18grib="18"
#Flags
arquivoExiste="OK"
arquivoNaoExiste="NOK"
#localGrib
URL="ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs."
#Arquivo
#Exemplo de arquivo: gfs.t00z.pgrb2.0p25.f002
#FILE="gfs.t00z.pgrb2.0p25.f002"

################################################################################################
#Aqui sera verificado se o link existe
#O modo 'spider' do wget, permite que ele obtenha tipos específicos de informação de páginas Web.
#Exemplo de endereco:ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.20210627/00/atmos/

###Horario da analise das 00 com previsao para 06, 12, 18
cd ${dir}
if test -d ../${data_completa}
then 
    echo "O diretorio existe"
    cd ../${data_completa}
else
    echo "O diretorio nao existe..."
    echo "Criando diretorio..."
    mkdir ../${data_completa}
    cd ../${data_completa}
fi

    for tAnalise in 00 06 12 18
    do
        if test ! -d ${tAnalise}
        then
            mkdir ${tAnalise}
            cd ${tAnalise}     
            for tPrev in 00 06 12 18
            do
                if test -e "gfs.t"${tAnalise}"z.pgrb2.0p25.f0"${tPrev} 
	        then
                    echo "Arquivo existe"
                else
                    echo "Arquivo nao existe"
                    echo "Verificando o diretorio do arquivo no NOAA: ${URL}${data_completa}/${tAnalise}/atmos/"        
                    wget --spider --quiet ${URL}${data_completa}"/"${tAnalise}"/atmos/" && flag=true || flag=false
                    if [ "${flag}" = "true" ]
                    then
                        echo "Site OK!"
                        echo "Fazendo download..."
                        wget ${URL}${data_completa}"/"${tAnalise}"/atmos/gfs.t"${tAnalise}"z.pgrb2.0p25.f0"${tPrev} 
                    else
                        echo "Site NOK!"
                    fi
                fi
            done
            cd ../
        fi
    done
    cd ../
    ls
###

################################################################################################
################################################################################################
################################################################################################
