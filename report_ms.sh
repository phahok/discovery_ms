# CHECK PATH / WORKSPACE REPO DISCOVERY RUNNER
# Shell Task discovery ms
# Jose Renato ( DevOps Architect )
# Douglas Oliveira ( Consulting SAS )
#
pathtmp=discovery_ms

echo "checando workspace repos para discovery ms report em /tmp para $(hostname -f)"
_workspace=/tmp/$pathtmp
echo -e

# Função checa path sas
checkpath(){
if [ -d "$_workspace" ]; then
        echo "Workspace temp '$_workspace' encontrada, efetuando limpeza ...!"
        rm -rf /tmp/$pathtmp
        cd /tmp; git clonegit@github.com:phahok/discovery_ms.git
else
        echo "Baixando repo Discovery MS em '$_workspace' ...!"
        echo -e
        echo "Criando WorkSpace Discovery MS "
        cd /tmp; git clone git@github.com:phahok/discovery_ms.git
fi
}

checkpath

echo -e "Coletando dados de discovery report em $(hostname) "
cd $_workspace
./Discovery_Main.sh

echo ------ Report finalizado 

echo -e "------ Publicando nova versão de report discovery ms"
git add Discovery.html; git commit -m "Versão atualizada report discovery gerada em : $(hostname -f)"
git push -u origin --all
