#!/usr/bin/python
import subprocess
import re
import os
import sys


def sort_tasks(current_task):
    return int(current_task[1])



DIR_NAME = os.path.abspath("./asp_files/") 
filename = DIR_NAME + "/query.asp"
def find_plan(init_state,goal_state):
    # query = "at("+init_state+", 0).\n:- not at("+destination+", n-1).\n#show approach/2.\n#show gothrough/2.\n#show opendoor/2."
    initial_at = "at("+init_state+", 0)."

    final_at = "\n:- not at("+goal_state+", n-1)."

    show_text = """     
                    \n#show approach/2.
                    \n#show gothrough/2.
                    \n#show opendoor/2.
                    \n#show goto/2.
                    \n#show at/2.
                    \n%#show beside/2.
                    \n%#show facing/2.
                """

    query2 =initial_at + final_at + show_text
    f = open(filename, "w")
    f.write(query2)
    f.close()

    goal_list=[]
    location_group = []
    output = "UNSATISFIABLE"
    minimal_step = 0
    max_step = 0
    while "UNSATISFIABLE" in str(output):
        if(max_step > 20):
            sys.exit()
        max_step= max_step + 1
        p = subprocess.Popen("clingo -c n="+str(max_step) + " -n 0" + " " + DIR_NAME +"/*.asp", stdout=subprocess.PIPE, shell=True)

        (output, err) = p.communicate()

        p_status = p.wait()
    minimal_step = max_step
    p = subprocess.Popen("clingo -c n="+str(max_step) + " -n 0" + " " + DIR_NAME +"/*.asp", stdout=subprocess.PIPE, shell=True)

    (output, err) = p.communicate()

    p_status = p.wait()
    plan=str(output)[str(output).find("Answer")+10:str(output).find("SATISFIABLE")]

    plan_list = plan.split()
    for actions in plan_list:
        location_step_pair = actions[actions.find("(")+1:actions.find(")")]
        location = location_step_pair.split(",")
        if actions.find('approach')!=-1:
            location.append(0)
            location_group.append(location)
        elif actions.find('opendoor')!=-1:
            location.append(1)
            location_group.append(location)
        elif actions.find('gothrough')!=-1:
            location.append(2)
            location_group.append(location)
        elif actions.find('unload')!=-1:
            location.append(4)
            location_group.append(location)
        elif actions.find('load')!=-1:
            location.append(3)
            location_group.append(location)
    location_group.sort(key = sort_tasks)
    return location_group
    # for goals in goal_list:
    #     print goals
# text_file = open("asp_output.txt", "w")
# text_file.write(mySubString)
# text_file.close()
#print "Command exit status/return code : ", p_status

if __name__ == '__main__':
    print(DIR_NAME)
    if len(sys.argv) != 3:
        raise "input init_state, final_goal"
    test = find_plan(sys.argv[1], sys.argv[2])
    print(test)