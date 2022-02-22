#!/bin/bash
# script que reorganiza (rebase) el branch corriente contra el branch de parametro

if [[ -d .git/rebase-merge ]]; then
    # verificar que no haya parametros, no los usamos
    if [[ $# -ne 0 ]]; then
        echo "Cuando tenes un conflicto va sin parametros"
        exit 1
    fi
    TARGET_BRANCH=`cat .git/rebase-merge/head-name | cut -c 12- `

    echo "Resolviste el conflicto?... a ver..."
    git rebase --continue || { echo "git rebase --continue volvio a fallar. fijate vos..."; exit 9; }

else
    # verificar que solo ingrese 1 parametro (el branch que me quiero traer)
    if [[ $# -ne 1 ]]; then
        echo "Use el comando con un parametro (el nombre del branch a traer)"
        echo $0 " <nombrebranch>"
        exit 1
    fi
	SOURCE_BRANCH=$1
	TARGET_BRANCH=`git status --short --branch --porcelain | head -n1 | cut -c4- | cut -d . -f 1`

	#verificar que no sean iguales los branch
	if [[ ${SOURCE_BRANCH} = ${TARGET_BRANCH} ]]; then
		echo "ERROR: El branch parametro '${SOURCE_BRANCH}' es igual al corriente. Chau"
		exit 3
	fi

    BR0a=`git status --porcelain -b | head -1 | grep behind`
    BR0b=`git status --porcelain -b | tail -n +2`

    if [[ ${BR0a} != "" ]]; then
		echo "ERROR: Estas desactualizado del branch de origen, tenes que hacer un rebase de tu branch primero antes de mergear."
		exit 1
    fi
    if [[ ${BR0b} != "" ]]; then
		echo "ERROR: Tenes archivos modificados en tu WC, para hacer merge tiene que estar todo limpio."
		exit 1
    fi

	echo "Fetch from remote last changes, sino va a fallar el push"
	git fetch origin ${SOURCE_BRANCH} || { echo "git fetch failed. fijate vos..."; exit 9; }

	# verificar que exista el branch $SOURCE_BRANCH
    BR1=`git branch --all --list ${SOURCE_BRANCH} origin/${SOURCE_BRANCH}`

	if [[ ${BR1} == "" ]]; then
		echo "ERROR: No existe el source branch '${SOURCE_BRANCH}'. Chau"
		exit 4
	fi

	echo "Git Rebase from '${SOURCE_BRANCH}' into '${TARGET_BRANCH}'"
	git rebase origin/${SOURCE_BRANCH} -s recursive || { git status; echo "git rebase failed. check log for details."; exit 1; }
fi

echo "Tenemos que hacer este hack porque no podemos hacer un push del branch directamente"
echo "Git Delete Remote '${TARGET_BRANCH}'"
git push origin --delete ${TARGET_BRANCH}

echo "Git Push changes in '${TARGET_BRANCH}'"
git push --set-upstream origin ${TARGET_BRANCH} --
