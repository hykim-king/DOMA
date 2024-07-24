package com.acorn.doma.code.domain;
import com.acorn.doma.cmn.DTO;
public class Code extends DTO{
    private String mstCode;  //마스터코드
    private String detCode;  //상세코드
    private String mstNm  ;  //마스터명
    private String detNm  ;  //상세명
    private int    seq    ;  //순서
    private String useYn;    //사용여부
    private String regDt;    //등록일
    private String regId;    //등록자
    private String modDt;    //수정일
    private String modId;    //수정자
    
    public Code(String mstCode, String detCode, String mstNm, String detNm, int seq, String useYn, String regDt,
            String regId, String modDt, String modId) {
        this.mstCode = mstCode;
        this.detCode = detCode;
        this.mstNm = mstNm;
        this.detNm = detNm;
        this.seq = seq;
        this.useYn = useYn;
        this.regDt = regDt;
        this.regId = regId;
        this.modDt = modDt;
        this.modId = modId;
    }
    public Code() {
    }
    public String getMstCode() {
        return mstCode;
    }
    public void setMstCode(String mstCode) {
        this.mstCode = mstCode;
    }
    public String getDetCode() {
        return detCode;
    }
    public void setDetCode(String detCode) {
        this.detCode = detCode;
    }
    public String getMstNm() {
        return mstNm;
    }
    public void setMstNm(String mstNm) {
        this.mstNm = mstNm;
    }
    public String getDetNm() {
        return detNm;
    }
    public void setDetNm(String detNm) {
        this.detNm = detNm;
    }
    public int getSeq() {
        return seq;
    }
    public void setSeq(int seq) {
        this.seq = seq;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getRegDt() {
        return regDt;
    }
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
    public String getRegId() {
        return regId;
    }
    public void setRegId(String regId) {
        this.regId = regId;
    }
    public String getModDt() {
        return modDt;
    }
    public void setModDt(String modDt) {
        this.modDt = modDt;
    }
    public String getModId() {
        return modId;
    }
    public void setModId(String modId) {
        this.modId = modId;
    }
    @Override
    public String toString() {
        return "Code [mstCode=" + mstCode + ", detCode=" + detCode + ", mstNm=" + mstNm + ", detNm=" + detNm + ", seq="
                + seq + ", useYn=" + useYn + ", regDt=" + regDt + ", regId=" + regId + ", modDt=" + modDt + ", modId="
                + modId + ", toString()=" + super.toString() + "]";
    }
    
    
}
