public class InsurancePlan  {
    
    private String insID;
    private String insProvider;
    private double insPercent;
    private String planType;

    public InsurancePlan(String insID, String insProvider, double insPercent, String planType) {
        this.insID = insID;
        this.insProvider = insProvider;
        this.insPercent = insPercent;
        this.planType = planType;
    }

    public String getInsID() {
        return insID;
    }

    public void setInsID(String insID) {
        this.insID = insID;
    }

    public String getInsProvider() {
        return insProvider;
    }

    public void setInsProvider(String insProvider) {
        this.insProvider = insProvider;
    }

    public double getInsPercent() {
        return insPercent;
    }

    public void setInsPercent(double insPercent) {
        this.insPercent = insPercent;
    }

    public String getPlanType() {
        return planType;
    }

    public void setPlanType(String planType) {
        this.planType = planType;
    }

}
