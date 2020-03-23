package global.sesoc.wareware.model;


import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.springframework.stereotype.Component;


public class SessionListener implements HttpSessionBindingListener {

    private static SessionListener sessionListner = null;

    private static Hashtable userList = new Hashtable();  // 로그인 유저정보를 담을 해쉬 테이블

    public int getUserCount() {
        return userList.size();
    }

    public boolean isUsing(String user_email) {  //해당 이메일 계정 접속중인지 여부
        return userList.containsValue(user_email);
    }

    public void setSession(HttpSession session, String user_email) { // 로그인이 완료된 사용자의 세션추가
        session.setAttribute(user_email, this); //name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)

    }

    public boolean chk_table(HttpSession session, String user_email) {
        return userList.containsValue(user_email);
    }


    public String getUserID(HttpSession session) {
        return (String) userList.get(session);
    }

    public void removeSession(String user_email) { //로그아웃이 세션지우기
        Enumeration e = userList.keys();
        HttpSession session = null;
        while (e.hasMoreElements()) {
            session = (HttpSession) e.nextElement();
            if (userList.get(session).equals(user_email)) {
                userList.remove(user_email);
                session.invalidate();
            }
        }
    }


    public void printloginUsers() {
        Enumeration e = userList.keys();
        HttpSession session = null;
        System.out.println("===========================================");
        int i = 0;
        while (e.hasMoreElements()) {
            session = (HttpSession) e.nextElement();
            System.out.println((++i) + ". 접속자 : " + userList.get(session));
        }
        System.out.println("===========================================");
    }

    //싱글톤
    public static synchronized SessionListener getInstance() {
        if (sessionListner == null) {
            sessionListner = new SessionListener();
        }
        return sessionListner;
    }

    //세션 연결시 호출됨
    @Override
    public void valueBound(HttpSessionBindingEvent event) {
        userList.put(event.getSession(), event.getName()); // 세션,이메일 해쉬테이블에 추가
    }

    //세션 해제시 호출됨
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        userList.remove(event.getSession()); // 로그아웃시 해당 세션의 아이디 해쉬테이블에서 제거
    }

}
