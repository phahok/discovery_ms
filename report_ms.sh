# CHECK PATH / WORKSPACE REPO DISCOVERY RUNNER
# Shell Task discovery ms
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
else
        echo "Baixando repo Discovery MS em '$_workspace' ...!"
        echo -e
        echo "Criando WorkSpace Discovery MS "
        cd /tmp; git clone git@ssh.dev.azure.com:v3/JoseRenatoFerreira/SAS_MS_TEAM/discovery_ms
fi
}

checkpath

echo -e "Coletando dados de discovery report em $(hostname) "
cd $_workspace
./Discovery_Main.sh