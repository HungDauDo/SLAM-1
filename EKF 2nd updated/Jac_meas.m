function Jmeas=Jac_meas(Xnow,Gas_re) % Measurement model Jacobian
r=sqrt((Xnow(1)-Gas_re(1))^2+(Xnow(2)-Gas_re(2))^2);
Jmeas=[(Xnow(1)-Gas_re(1))/r (Xnow(2)-Gas_re(2))/r 0;(Gas_re(2)-Xnow(2))/r^2 (Gas_re(1)-Xnow(1))/r^2 -1];
end
