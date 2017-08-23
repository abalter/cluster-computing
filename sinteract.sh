function sinteract ()
{
    #echo "in function interactive"

    local cpus=""
    local memory=""
    local node=""
    local time=""
    local cmd="srun "
    local execute=true

    #echo "starting to parse args $@"

    local OPTIND
    local OPTARG
    local opt

    while getopts ":m:c:n:t:h" opt; do
        #echo "parsing arg $opt"
        
        case "$opt" in
            h)
                echo "\
                usage:
                ------
                sinteract [ -h ] [ -c CUPS ] [ -m MEMORY ] [ -t TIME ] [ -n NODE ]
                
                description:
                ------------
                Initiates an interactive slurm session. Note: the two available
                slurm head nodes as of 01-03-2017 are exahead1 and exahead2.

                optional arguments:
                -------------------
                -h          Print this help message and exit.
                -c CPUS     Request CPUS number of cores.
                -m MEMORY   Request MEMORY amount of RAM. The
                            default units are megabyts. However
                            The following suffixes can be used:
                            [K|M|G|T]
                 -t TIME     Request connection time. Acceptable time formats:
                                minutes
                                minutes:seconds
                                hours:minutes:seconds
                                days-hours
                                days-hours:minutes
                                days-hours:minutes:seconds

                -n NODE     Request a particular child node, e.g. 2-5
                "
                execute=false
                #exit 2
                ;;
            c)
                cpus="$OPTARG"
                cmd="$cmd --mincpus $cpus"
                #echo "cpus=$cpus"
                ;;
            m)
                memory="$OPTARG"
                cmd="$cmd --mem ${memory}"
                #echo "memory=$memory"
                ;;
            n)
                node="$OPTARG"
                cmd="$cmd --nodelist \"exanode-${node}\""
                #echo "node=$node"
                ;;
            t)
                time="$OPTARG"
                cmd="$cmd --time ${time}"
                #echo "time=$time"
                ;;                         
            ?)
                echo "Error: did not recognize option, ${OPTARG}."
                echo "Please try -h for help."
                execute=false
                #exit 1
                ;;
        esac
    done

    if [[ $execute == true ]]; then
        cmd="$cmd --pty bash"
        echo $cmd
        eval $cmd
    fi
}

