package trainer_schedule.dto;

public class MemberScheduleDTO {

	 private String memberId;
	    private String name;
	    private String phone;

	    public MemberScheduleDTO() {}

	    public MemberScheduleDTO(String memberId, String name, String phone) {
	        this.memberId = memberId;
	        this.name = name;
	        this.phone = phone;
	    }

	    public String getMemberId() {
	        return memberId;
	    }

	    public void setMemberId(String memberId) {
	        this.memberId = memberId;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getPhone() {
	        return phone;
	    }

	    public void setPhone(String phone) {
	        this.phone = phone;
	    }

	    @Override
	    public String toString() {
	        return "MemberDTO{" +
	                "memberId='" + memberId + '\'' +
	                ", name='" + name + '\'' +
	                ", phone='" + phone + '\'' +
	                '}';
	    }
	} 
