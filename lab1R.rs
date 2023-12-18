use std::io;
use std::env;

type Double = f64;

enum Roots {
    NoRoots,
    OneRoot (Double),
    TwoRoots (Double, Double),
    ThreeRoots (Double, Double, Double),
    FourRoots (Double, Double, Double, Double),
}

fn show_roots(r: Roots){
    match r{
        Roots::NoRoots => println!("Нет корней"),
        Roots::OneRoot(x) => println!("Один корень {}", x),
        Roots::TwoRoots(x1, x2) => println!("Два корня: {} и {}", x1, x2),
        Roots::ThreeRoots(x1, x2, x3) => println!("Три корня: {}, {} и {}", x1, x2, x3),
        Roots::FourRoots(x1, x2, x3, x4) => println!("Четыре корня: {}, {}, {}, {}", x1, x2, x3, x4)
    }
}

fn solve(tuple: (Double, Double, Double)) -> Roots{
    let a = tuple.0;
    let b = tuple.1;
    let c = tuple.2;
    let dis = b * b - 4.0 * a * c;
    if dis < 0.0 || dis == 0.0 && (-b)/(2.0 * a) < 0.0 || a == 0.0{
        Roots::NoRoots
    }
    else if dis == 0.0 && (-b)/(2.0 * a) == 0.0{
        Roots::OneRoot (0.0)
    }
    else if dis == 0.0{
        let x = (-b)/(2.0 * a);
        Roots::TwoRoots(x.sqrt(), -x.sqrt())
    }
    else {
        let x1 = (-b + dis.sqrt())/(2.0 * a);
        let x2 = (-b - dis.sqrt())/(2.0 * a);
        if x1 > 0.0 && x2 < 0.0{
            Roots::TwoRoots(x1.sqrt(), -x1.sqrt())
        }
        else if x1 < 0.0 && x2 > 0.0{
            Roots::TwoRoots(x2.sqrt(), -x2.sqrt())
        }
        else if x1 == 0.0 && x2 > 0.0{
            Roots::ThreeRoots(0.0, x2.sqrt(), -x2.sqrt())
        }
        else if x1 > 0.0 && x2 == 0.0{
            Roots::ThreeRoots(0.0, x1.sqrt(), -x1.sqrt())
        }
        else if x1 > 0.0 && x2 > 0.0{
            Roots::FourRoots(x1.sqrt(), -x1.sqrt(), x2.sqrt(), -x2.sqrt())
        }
        else {
            Roots::NoRoots
        }
    }
}

fn get_3c() -> (Double, Double, Double){
    let args: Vec<String> = env::args().collect();
    if args.len() == 4{
        let a = args[1].trim().parse().expect("Ошибка парсинга");
        let b = args[2].trim().parse().expect("Ошибка парсинга");
        let c = args[3].trim().parse().expect("Ошибка парсинга");
        (a, b, c)
    }
    else {
        println!("Введите коэффициент А:\n");
        let a = get_c();
        println!("Введите коэффициент В:\n");
        let b = get_c();
        println!("Введите коэффициент С:\n");
        let c = get_c();
        (a, b, c)
    }
}

fn get_c() -> Double {
    let mut number = String::new();
    io::stdin().read_line(&mut number).expect("Ввод некорректный!");

    if let Ok(x) = number.trim().parse::<Double>() {
        x
    } else {
        println!("Ошиба! Постарайтесь ввести все-же число:/");
        get_c()
    }
}

fn main(){
    show_roots(solve(get_3c()));
}
    