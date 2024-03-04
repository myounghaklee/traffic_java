# AOP
- Aspect(관점) : 애플리케이션의 특정 관심사를 나타낸다. 로깅, 트랜잭션 관리 보안등등
```java
@Aspect
public class LoggingAspect {
    // 여기에 Advices 정의
}
```
- Advicce(조언) : 수행할 행동을 나타낸다. 메소드 실행전에 어떤 작업을 수행하는 advice가 있을 수 있다.
```java
@Before("execution(* com.example.service.*.*(..))")
public void beforeAdvice(JoinPoint joinPoint) {
    System.out.println("Before method: " + joinPoint.getSignature().getName());
}
```
- JoinPoint(결합지점) : 어드바이스가 실행되는 시점. 메서드 호출, 필드 접근이 결합지점이 될 수 있음
- Pointcut(지점) : 어드바이스를 적용할 결합 지점의 집합. 정규 표현식이나 패턴을 사용하여 결합지점을 지정할 수 있음
```java
@Pointcut("execution(public * *(..))")
private void anyPublicOperation() {}
```
- Weaving(위빙) : Aspecdt를 적용하여 애플리케이션 코드에 Aspect의 행위를 삽입하는 과정
- Around : Advice유형중 하나로 타겟 메서드를 감싸서 호출 전후에 코드를 실행할 수 잇게 해주는 어노테이션
```java
@Around("execution(* com.example.service.*.*(..))")
public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
    System.out.println("Before method execution");
    Object returnValue = joinPoint.proceed(); // 타깃 메소드 실행
    System.out.println("After method execution");
    return returnValue;
}
```
---- 
## DynamicProxy
AOP 구현방식중 하나. 프록시 객체를 동적으로 ㅅ애성하여 타겟 객체를 감싸는 방식
- JDK Dynamic Proxy : JDK의 `java.lang.reflect.Proxy` 클래스를 사용해서 인터페이스 기반의 프록시 생성
- CGLIB Proxh : Class Generation Library를 사용하여 클래스 기반의 프록시 생성. 인터페이스를 구현하지 않은 클래스에 대한 프록시를 생성할 수 있다.

기본적으로 spring boot project는 JDK방식이다. 

### JDK Dynamic Proxy 예제

ava에서 Dynamic Proxy는 런타임에 동적으로 인터페이스 기반의 프록시 객체를 생성하는 기능을 제공합니다. 이를 통해 개발자는 특정 인터페이스를 구현하는 클래스의 인스턴스에 대한 호출을 가로채어 추가적인 처리를 할 수 있게 됩니다. 주로, 인터페이스 기반의 의존성 주입, AOP(Aspect-Oriented Programming) 프록시, 트랜잭션 관리 등에서 활용됩니다.

Dynamic Proxy의 작동 원리
Java의 java.lang.reflect.Proxy 클래스를 사용하여 구현합니다. 이 클래스는 InvocationHandler 인터페이스를 구현한 객체를 사용하여 메소드 호출을 처리합니다. InvocationHandler의 invoke 메소드는 프록시된 인터페이스의 모든 메소드 호출을 가로챕니다. 개발자는 invoke 메소드 내에서 원하는 로직(예: 메소드 호출 전후에 로깅)을 구현할 수 있습니다.
```java
// interface
public interface MyInterface {
    void doSomething();
}

//handler
public class MyInvocationHandler implements InvocationHandler {
    private final Object target;

    public MyInvocationHandler(Object target) {
        this.target = target;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("Before method: " + method.getName());
        Object result = method.invoke(target, args); // 실제 객체의 메소드를 호출
        System.out.println("After method: " + method.getName());
        return result;
    }
}

// use
public class DynamicProxyExample {
    public static void main(String[] args) {
        MyInterface originalObject = new MyInterfaceImpl(); // MyInterface를 구현하는 실제 객체
        MyInterface proxyInstance = (MyInterface) Proxy.newProxyInstance(
                MyInterface.class.getClassLoader(),
                new Class[]{MyInterface.class},
                new MyInvocationHandler(originalObject)
        );

        proxyInstance.doSomething(); // 프록시를 통해 메소드 호출
    }
}
```
------
# 성능테스트
## Stress test
최대부하 테스트. 성능한계확인하고 부하처리 능력 평가, 대량의 동시 사용자 또는 트랜잭선을 생성해서 어ㅓ플리케이션의 응답 시간과 자원 소모 모니터링
## Spike test
갑작스러운 부하 증가에 대한 어프릴케이션의 대응능력 테스트.
## Endurance test 
어플리테이션을 장기간 실행하는 테스트로 지속적 부하를 가하거나 특정 부하를 유지하는 시나리오에서 어플리케이션 안정성을 확보
안정성, 메모리 누수, 자원 누수 등을 검증하는데 사용됨. 성능저하나 시스템 장애를 경험하지 않는지 확인할 수 있다. 

## 성능테스트 툴
- Locust : python으로 개발되어 사용자 정의 가능한 스크립트 작성. 분산된 테스트를 지원하며 테스트 시나리오 프로그래밍하여 동적 부하를 생성할 수 있음. 
- JMeter : 다양한 프로토콜 및 응용 테스트 지원. 대규모 테스트 및 복잡한 시나리오에 적합, 다양한 플러그인 확장 가능
- Gatling : Scala 사용하여 사용자 정의 시나리오 구성한다. 비동기 자겅ㅂ 및 스트리밍 시나리오 지원. 