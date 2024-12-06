%%Rib Placement: Calculates the placement of ribs according the stringer
%buckling
%Alyssa A Rutherford
%5 December 2024

%%Variables:
b = 3.8859+3.9067; %length of skin on both sides
Eskin = 1926*10^3; 
t = .125; %Thickness of stringers
nstr = 8; %Number of stringers
Astr = .015675; %Area of Stringers
h = .03125; %Thickness of Skin
nr = 3; %Curvature Constant
s = b/(nstr+1); %Average distance between strigners
H = h+t; %Distance from edge of skin to top of stringer

%%Loop Presets
Ncr = 0;
Nx = 1;
i = 0;
x = 1; %Location on Wing, offset for fixed rib
y = ; %y centroid
z = ; %z centroid

%%EXPLANATION OF sumf
%Need to use the bedning stress equation and the centroid of all the
%stringers and sum that stress. Maybe use some sort of matrix to hold all
%of the y and z coordinates and use a loop that calculates the individual 
%stresses goes until the end of the matrix, and adds the stresses along the
%way. Like the (i,1) and (i,2) sort of thing but for ys and zs.

%%Loop
while x < 46
    i = i+1; %Loop/Rib Count
    a = 0;
    while Ncr<=1.3*Nx
        a = a+0.125; %Rib Spacing
        stress_normal = -y * ((load - 5) * (x - 45.75) * i_yz / (i_yy * i_zz - i_yz^2)) ...
        + z * (load - 5) * (x - 45.75) * i_zz / (i_yy * i_zz - i_yz^2); %Bending stress eq
        Fskin = h*b*stress_normal; %Force of Skin
        Fstr = t^2*sumf; %Reaction Force of Stringer
        Nx = 1/b*(Fskin+Fstr); %Total Force
        Ncr = nr*(pi^2)/(b^2)*(a/b+b/a)^2*(Eskin*s*h^3)/(12*(s-t+t*(h/H)^3)); %Critical (Failure) Force
        if a > b
            fprintf('TOO LARGE A')
            break
        end
    end
    Rib_Space(i,1) = a;
    Rib_Space(i,2)= x;
    x = x+a;
    if i>15 
        fprintf('MAX RIBS REACHED')
        break
    end
end





%%SCRAPPED
%const = nr*(pi^2)/(b^2)*(Eskin*s*h^3)/(12*(s-t+t*(h/H)^3))
%const1 = nr*(pi^2)/(b^2)
%const2 = (Eskin*h^3)
%const3 = 12*(-t+t*(h/H)^3)
    
