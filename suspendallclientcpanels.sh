# Bash script to first list and then possibly suspend cPanels that belongs to defined e-mail address

echo "Enter e-mail address. All active/not suspended Panels with this e-mail will be printed out below. (nothing suspended yet)"
read mail
echo ""

#### LISTING

for cpanelpath in $(grep -Ril "$mail" /var/cpanel/users);do
echo "$mail owns cPanel $(basename $cpanelpath)"
done

#### SUSPENSION

echo -e "\nSuspend all above mentioned cPanels now? (y = yes)"
read todo
if [[ "$todo" == "y" ]];then
for cpanelpath in $(grep -Ril "$mail" /var/cpanel/users);do
/scripts/suspendacct $(basename $cpanelpath) "TOS violation, bulk suspension, $mail"
done
fi

#### VERIFFY SUSPENDED

echo -e "\nNow search in suspended accounts directory and list all cPanels that match $mail:"
grep -Ril "$mail" /var/cpanel/suspended
echo -e "\nScript finished."
#
