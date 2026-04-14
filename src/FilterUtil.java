import java.util.ArrayList;
import java.util.function.Predicate;

/*
this is a global class which can be used to filter any list of objects obtained from any of the getall() methods
<T> is a generic type parameter, so it works with any type of object
Predicate can be a bit confusing so here's an example (of it being used from another class):

PatientImpl patientDAO = new PatientImpl();
FilterUtil.filter(patientDAO.getAllPatients(), p -> p.getAge() > 30); // shows all patients older than 30

In short, the p -> declares a Patient p which is used for each element in the ArrayList, and then the condition is applied (there's technically a bit more to it but it doesn't matter)

Sorry if this is confusing lol I'm just now learning too haha
*/

// i know this isn't an actual SQL implementation of like a WHERE clause or something like that, but this is so much simpler than figuring out how to load an SQL query
public class FilterUtil {
    public static <T> ArrayList<T> filter(ArrayList<T> items, Predicate<T> condition) {
        ArrayList<T> filteredItems = new ArrayList<>();
        for (T item : items) {
            if (condition.test(item)) {
                filteredItems.add(item);
            }
        }
        return filteredItems;
    }

    // mutil-condition version (?)
    public static <T> ArrayList<T> filter(ArrayList<T> items, ArrayList<Predicate<T>> conditions) {
        ArrayList<T> filteredItems = new ArrayList<>();
        for (T item : items) {
            boolean allConditionsMet = true;
            for (Predicate<T> condition : conditions) {
                if (!condition.test(item)) {
                    allConditionsMet = false;
                    break;
                }
            }
            if (allConditionsMet) {
                filteredItems.add(item);
            }
        }
        return filteredItems;
    }
}
