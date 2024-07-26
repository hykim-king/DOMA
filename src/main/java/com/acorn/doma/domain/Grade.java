package com.acorn.doma.domain;

public class Grade {
	private int gradeSeq;
	private int grade;
	public Grade() {}
	
	public Grade(int gradeSeq, int grade) {
		super();
		this.gradeSeq = gradeSeq;
		this.grade = grade;
	}

	public int getGradeSeq() {
		return gradeSeq;
	}
	public void setGradeSeq(int gradeSeq) {
		this.gradeSeq = gradeSeq;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "Grade [gradeSeq=" + gradeSeq + ", grade=" + grade + "]";
	}
	
}
