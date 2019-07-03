#!/usr/bin/python
import subprocess
import re
import sys


def sort_tasks(current_task):
    return int(current_task[1])



def find_plan(current_room,task_list,constraintin):
    # query = "at("+current_room+", 0).\n:- not at("+destination+", n-1).\n#show approach/2.\n#show gothrough/2.\n#show opendoor/2."
    currently_at = "at("+current_room+", 0)."

    object_location = "\nlocated(s0, r1_staff_area, 0).\n -loaded(s0,0).\nlocated(s1, r1_corr_j, 0).\n -loaded(s1,0).\nlocated(s2, r1_corr_watson, 0).\n -loaded(s2,0).\nlocated(s3, r1_corr_watson, 0).\n -loaded(s3,0).\nlocated(s4, r1_corr_g, 0).\n -loaded(s4,0).\nlocated(s5, r1_corr_h, 0).\n -loaded(s5,0)."
    constraint_text = ""
    return_to = "\n:- not at("+current_room+", n-1)."

    locations = ""
    # location_names = ["r1_corr_watson","r1_staff_area","r1_corr_h"]
    items_to_bring = ""
    items_to_bring = items_to_bring + "\n:- not located(s"+str(task_list)+", r1_h9_area, n-1)."
    show_text = "\n#show load/2.\n#show unload/2.\n#show approach/2.\n#show gothrough/2.\n#show opendoor/2.\n%#show at/2.\n%#show beside/2.\n%#show facing/2.\n"
    if constraintin != "1":
        constraint_text=""
    # if constraint == "1":
    #     constraint_tex  t = constraint_text + "\n:- load("+constraint[0]+", I), I=0.."+str(constraint[1])+"."

    query2 =currently_at + object_location + items_to_bring + constraint_text + show_text
    f = open("/home/vidisha/ar_project_ws/src/asp_navigation/asp_files/query.asp","w")
    f.write(query2)
    f.close()
    goal_list=[]
    location_group = []
    output = "UNSATISFIABLE"
    i=0
    while "UNSATISFIABLE" in output:
        if(i>40):
            sys.exit()
        i= i+1
        p = subprocess.Popen("clingo -c n="+str(i)+" ~/ar_project_ws/src/asp_navigation/asp_files/*.asp", stdout=subprocess.PIPE, shell=True)

        (output, err) = p.communicate()

        p_status = p.wait()

    p = subprocess.Popen("clingo -c n="+str(i)+" ~/ar_project_ws/src/asp_navigation/asp_files/*.asp", stdout=subprocess.PIPE, shell=True)

    (output, err) = p.communicate()

    p_status = p.wait()
    plan=output[output.find("Answer")+10:output.find("SATISFIABLE")]

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
