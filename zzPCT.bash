#!/bin/bash
# http://pastebin.com/98bcLyHw
function  _zzPCT_HELP
{
          zzPCT_HELP=(
                      "####################################################################"
                      "#"
                      "#                              zzPCT"
                      "#"
                      "#    INTRO:"
                      "#             This function takes 2 or 3 arguments."
                      "#"
                      "#             $1 = Total count of elements   (as a number)"
                      "#             $2 = Current index of elements (as a number)"
                      "#             $3 = Output type               (as a number)"
                      "#"
                      "#             Then returns the percentage of [SMALLER_NUMBER] vs [BIGGEST_NUMBER]"
                      "#"
                      "#     NOTE:   It doesnt matter which number you give as $1 or $2, as"
                      "#             this function will always re-arrange them based on which"
                      "#             is larger."
                      "#"
                      "#    USAGE:   zzPCT  [MAX_NUMBER]   [CUR_NUMBER]   [OUTPUT_TYPE]"
                      "#"
                      "#  EXAMPLE:   zzPCT      100             50"
                      "#   RESULT:   50/100 ( 50.00% )"
                      "#"
                      "#  EXAMPLE:   zzPCT      100             50              7"
                      "#   RESULT:   050.00%"
                      "#"
                      "#  EXAMPLE:   TRY IT"\!
                      "#"
                      "              NUM_1=9999"
                      "              NUM_2=9998"
                      "              zzPCT \${NUM_1} \${NUM_2} {1..8}"
                      "#   RESULT:"
                      "#             9999/9998 ( 99.98% )"
                      "#             99"
                      "#             99%"
                      "#             99.98"
                      "#             99.98%"
                      "#             099.98"
                      "#             099.98%"
                      "#"
                      "####################################################################"
                    )
 
          printf   "%s\n"   "${zzPCT_HELP[@]}"
          unset zzPCT_HELP
          return 0
}
 
 
function  zzPCT
{
          # ADDED: if zero, return zero
		  if [ $1 -eq 0 ]; then
			printf "0"
			return 0
		  fi
		  
		  unset ${!zzPCT_*}
 
          if    [ ${#*} -eq 0 ] || [ "${*}" != "${*//-[hH]}" ]
          then  _zzPCT_HELP 2>/dev/null || printf "%s\n" \
                                                  "#   usage: zzPCT  [NUMBER]  [FRACTION]  [OUTPUT_TYPE](1 to 8)" \
                                                  "# example: zzPCT    10           3            1"
                return 1
          fi
 
          for   zzPCT_i  in  ${*//[^0-9]/ }  ;  do
                if    [ ${#zzPCT_THIS} -eq 0 ]
                then  zzPCT_THIS=${zzPCT_i}
                elif  [ ${#zzPCT_BY} -eq 0 ]
                then  zzPCT_BY=${zzPCT_i}
                else  zzPCT_RETURN_TYPE=( "${zzPCT_RETURN_TYPE[@]}"   "${zzPCT_i}"  )
                fi
          done
 
          if    [ ${#zzPCT_THIS}${#zzPCT_BY} -lt 11 ]
          then  printf   "%s\n"   "${zzPCT_HELP[@]}"  ;  return 1
          fi
 
          if    [ ${zzPCT_THIS} -lt ${zzPCT_BY} ]
          then  zzPCT_THIS_TMP=${zzPCT_THIS}  ;  zzPCT_THIS=${zzPCT_BY}      ;  zzPCT_BY=${zzPCT_THIS_TMP}
          fi
 
          if    [ ${zzPCT_THIS} -eq  ${zzPCT_BY} ]
          then
                zzPCT_G=1
                zzPCT_E=0000
          else
                zzPCT_G=0
 
                zzPCT_A=${zzPCT_THIS}00
                zzPCT_B=100${zzPCT_A//[^0]/0}
                zzPCT_C=$(( zzPCT_B / zzPCT_A ))
                zzPCT_D=$(( zzPCT_C * zzPCT_BY ))
                zzPCT_E=${zzPCT_D}
 
                while [ ${#zzPCT_E} -lt ${#zzPCT_A} ] ; do
                      zzPCT_E=0${zzPCT_E}
                done
          fi
 
 
          zzPCT_N=${zzPCT_E:0:2}
          if [ ${zzPCT_N} -ne 0 ] ; then zzPCT_N=${zzPCT_N#0*} ; fi
 
          for   zzPCT_CUR_RETURN_TYPE   in  ${zzPCT_RETURN_TYPE[@]:-1}
          do
 
                case  "${zzPCT_CUR_RETURN_TYPE}"  in
 
                      1 ) zzPCT_F="${zzPCT_BY}/${zzPCT_THIS} ( ${zzPCT_G/0/}${zzPCT_N}% )"                 ;; #  99/100 ( 99% )
                      2 ) zzPCT_F="${zzPCT_BY}/${zzPCT_THIS} ( ${zzPCT_G/0/}${zzPCT_N}.${zzPCT_E:2:2}% )"  ;; #  99/100 ( 99.00% )
                      3 ) zzPCT_F=${zzPCT_G/0/}${zzPCT_N}                                                  ;; #  99
                      4 ) zzPCT_F=${zzPCT_G/0/}${zzPCT_N}%                                                 ;; #  99%
                      5 ) zzPCT_F=${zzPCT_G/0/}${zzPCT_E:0:2}.${zzPCT_E:2:2}                               ;; #  99.00
                      6 ) zzPCT_F=${zzPCT_G/0/}${zzPCT_E:0:2}.${zzPCT_E:2:2}%                              ;; #  99.00%
                      7 ) zzPCT_F=${zzPCT_G}${zzPCT_E:0:2}.${zzPCT_E:2:2}                                  ;; #  099.00
                      8 ) zzPCT_F=${zzPCT_G}${zzPCT_E:0:2}.${zzPCT_E:2:2}%                                 ;; #  099.00%
                      * ) zzPCT_F="${zzPCT_BY}/${zzPCT_THIS} ( ${zzPCT_G/0/}${zzPCT_N}% )"                 ;; #  99/100 ( 99% )
                esac
                printf "%s\n" "${zzPCT_F}"
          done
 
          # DEBUG # printf "%10s  %10s  %10s  %10s  %10s  %10s\n"  "zzPCT_A" "zzPCT_B" "zzPCT_C" "zzPCT_D" "zzPCT_E" "zzPCT_F"   "${#zzPCT_A}" "${#zzPCT_B}" "${#zzPCT_C}" "${#zzPCT_D}" "${#zzPCT_E}" "${#zzPCT_F}"    "${zzPCT_A}"  "${zzPCT_B}"  "${zzPCT_C}"  "${zzPCT_D}"  "${zzPCT_E}"  "${zzPCT_F}"
 
          unset ${!zzPCT_*}
          return 0
}