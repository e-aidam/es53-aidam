function renal_sim4(p1)
    global STOP_SIM;
    global PAUSE_SIM;
    
    Blood_Volume = p1.Blood_Volume;
    dt = p1.dt;
    NUM_STEPS = p1.Num_Steps;
    N = zeros(NUM_STEPS,1); 
    Added = N; 
    Removed = N; 
    Bolus = N; 
    GFR = N; 
    Creation_Rate = N;
    N(1) = p1.Initial_Conc * p1.Blood_Volume;

    tic;
    for k = 1:NUM_STEPS-1,
   k
        if STOP_SIM
            return; 
        end

        while(PAUSE_SIM)
            pause(0.1);
        end
        s = renal_sim_interface2('get_settings');
        Bolus(k) = s.CR_BOLUS; 
        Creation_Rate(k) = s.CR_RATE; 
        GFR(k) = s.GFR;

        Added(k) = Bolus(k) + Creation_Rate(k)*dt;
        Removed(k) = (N(k)/Blood_Volume)*GFR(k)*dt;
        N(k+1)= N(k) + Added(k) - Removed(k);

        p.k = k; 
        p.Added=Added; 
        p.Removed=Removed; 
        p.N=N; 
        renal_sim_interface2('update_display', p);
    end
    renal_sim_interface2('stop');
    save(p1.FileName); 
    toc
