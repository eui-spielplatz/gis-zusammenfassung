UGSRES = 100;
UDSRES = 100;
UTHRESHOLD = 1.2;
UGSMAX = 5;
UDSMAX = 5;
BETA = 1.5; % in A / V^2
ugs_lin = linspace(0, UGSMAX, UGSRES)';
uds_lin = linspace(0, UDSMAX, UDSRES)';

hold on;
set(gca, "linewidth", 4, "fontsize", 14, "fontweight", "bold");

% Plot 3d graph
id = zeros(UGSRES, UDSRES);
for ugs_i = 1:UGSRES
  for uds_i = 1:UDSRES
    ugs = ugs_lin(ugs_i);
    uds = uds_lin(uds_i);

    % Cutoff
    if (ugs - UTHRESHOLD < 0)
      ids(ugs_i, uds_i) = 0;

    % Linear mode
    elseif (uds < ugs - UTHRESHOLD)
      id(ugs_i, uds_i) = BETA * ((ugs - UTHRESHOLD) * uds - uds^2/2);

    % Saturation mode
    else
      id(ugs_i, uds_i) = BETA / 2 * (ugs - UTHRESHOLD)^2;
    end
  end
end

mesh(uds_lin, ugs_lin, id);

% Plot border to cutoff region
plot3([0 UDSMAX], [UTHRESHOLD UTHRESHOLD], [0 0], "r", "linewidth", 5);

% Plot border linear / saturation region
border_ugs = linspace(UTHRESHOLD, UGSMAX, 100);
border_uds = border_ugs - UTHRESHOLD;
border_id = BETA / 2 * (border_ugs - UTHRESHOLD).^2;

plot3(border_uds, border_ugs, border_id, "b", "linewidth", 5);

xlabel("U_{DS}");
ylabel("U_{GS}");
zlabel("I_D");

title ("n-Channel-MOSFET");