public class RequestResponseWrapper {
    public String status;
    public String photo;
    public String name;
    public String id;
    public String description;
    public String breed;
    public Integer age;

    public void print() {
        System.debug('\n' + JSON.serializePretty(this) + '\n');
    }
}