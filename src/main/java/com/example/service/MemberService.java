package com.example.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.domain.NoticeVo;
import com.example.domain.PattachVo;
import com.example.mapper.MemberMapper;
import com.example.mapper.PattachMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.java.Log;

@Log
@Service
@Transactional  // 이 클래스의 모든 메소드가 각각 한개의 트랜잭션 단위로 수행됨
public class MemberService {

	// 스프링 빈으로 등록된 객체들 중에서
	// 타입으로 객체의 참조를 가져와서 참조변수에 저장해줌
	private MemberMapper memberMapper;

	@Autowired
	private PattachMapper pattachMapper;


	public String getGender(String id) {
		String gender = memberMapper.getGender(id);

		return gender;
	}


	public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&code=" + authorize_code);
            sb.append("&client_id=자신의API&");  //본인이 발급받은 key
            sb.append("redirect_uri=http://localhost:8082/member/kalogin");     // 본인이 설정해 놓은 경로
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }

	 public HashMap<String, Object> getUserInfo (String access_Token) {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String name = properties.getAsJsonObject().get("nickname").getAsString();
            String profile = properties.getAsJsonObject().get("profile_image").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();

            userInfo.put("name", name);
            userInfo.put("email", email);
            userInfo.put("profile", profile);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userInfo;
    }
	 



	 public int getCountBySearch(String category, String search) {
		int count = memberMapper.getCountBySearch(category, search);
		return count;
	 }

	 public List<MemberVo> getMembersBySearch(int startRow, int pageSize, String category, String search) {
		return memberMapper.getMembersBySearch(startRow, pageSize, category, search);
	}

	@Autowired
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	public MemberVo getMemberById(String id) {
		MemberVo memberVo = memberMapper.getMemberById(id);
		return memberVo;
	}
	
	public int getMemberGender(String id) {
		int gender = memberMapper.getMemberGender(id);
		return gender;
	}

	public String getTotalById(String id){
		String price = memberMapper.getTotalById(id);
		return price;
	}


	public void addMember(MemberVo memberVo) {
		memberMapper.addMember(memberVo);
	}



	public List<MemberVo> getAllMembers() {
		List<MemberVo> list = memberMapper.getAllMembers();
		return list;
	}


	public int userCheck(String id, String passwd) {
		int check = -1;

		String dbPasswd = memberMapper.userCheck(id);

		if (dbPasswd != null) {
			if (passwd.equals(dbPasswd)) {
				check = 1;
			} else {
				check = 0;
			}
		} else { // dbPasswd == null
			check = -1;
		}
		return check;
	}

	public String getUserPW(String id, String name, String email) {
		String passwd = "";

		String dbPasswd = memberMapper.findUserPasswd(id, name, email);

		int count = 0;

		count = memberMapper.userCheckPasswd(id, name, email);

		if (count == 0) {
			passwd = null;
		} else if (count == 1){ // dbPasswd == null
			passwd = dbPasswd;
		}
		return passwd;
	}

	public String getUserID(String name, String email) {
		String findId = "";

		String dbId = memberMapper.findUserID(name, email);

		int count = 0;

		count = memberMapper.userCheckID(name, email);

		if (count == 0) {
			findId = null;
		} else if (count == 1){ // dbPasswd == null
			findId = dbId;
		}
		return findId;
	}

	public int getCountById(String id) {
		int count = memberMapper.getCountById(id);
		return count;
	}

	public int getCountByEmail(String email) {
		int count = memberMapper.getCountByEmail(email);
		return count;
	}

	public void update(MemberVo memberVo) {
		memberMapper.update(memberVo);
	}

	public void deleteById(String id) {
		memberMapper.deleteById(id);
	}

	public void deleteAll() {
		memberMapper.deleteAll();
	}

	public List<Map<String, Object>> getGenderPerCount() {
		List<Map<String, Object>> list = memberMapper.getGenderPerCount();
		return list;
	}

	public List<Map<String, Object>> getAgeRangePerCount() {
		List<Map<String, Object>> list = memberMapper.getAgeRangePerCount();
		return list;
	}

	public void addPattaches(List<PattachVo> pattachList) {
		// 첨부파일정보 등록
		for (PattachVo pattachVo : pattachList) {
			pattachMapper.insertPattach(pattachVo);
		}
	}

	public void updateMemberAneAddPattachedAndDeletePattaches(MemberVo memberVo, List<PattachVo> pattachList, List<Integer> delFileNums) {
		memberMapper.update(memberVo);

		for(PattachVo pattachVo : pattachList) {
			pattachMapper.insertPattach(pattachVo);
		}

		if(delFileNums != null) {
			pattachMapper.deletePattachedByNums(delFileNums);
		}
	}

}







