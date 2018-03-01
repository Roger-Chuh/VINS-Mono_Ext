%%
% plot current state of isam2
function swing_simulation_ISAM_Plot(truth, data, isam, result, options)

h=gca;
cla(h);
hold on;

%% Plot points
% Can't use data because current frame might not see all points
marginals = Marginals(isam.getFactorsUnsafe(), isam.calculateEstimate()); % TODO - this is slow
gtsam.plot3DPoints(result, [], marginals);

%% Plot cameras
import gtsam.*
M = 1;
while result.exists(symbol('x',M))
    ii = symbol('x',M);
    pose_i = result.at(ii);
    if options.hardConstraint && (M==1)
        gtsam.plotPose3(pose_i,[],1); % 10
    else
        P = marginals.marginalCovariance(ii);
        gtsam.plotPose3(pose_i,P,1); % 10
    end
    if options.drawTruePoses % show ground truth
        gtsam.plotPose3(truth.cameras{M}.pose,[],1);
    end
    
    M = M + options.cameraInterval;
end

%% draw
% axis([-40 40 -40 40 -10 20]);axis equal
axis([-2 2 -1 14 -1 4]);axis equal
view(3)
colormap('hot')
drawnow
grid on;
xlabel('x')
ylabel('y')
zlabel('z')
%% do various optional things

if options.saveFigures
    figToSave = figure('visible','off');
    newax = copyobj(h,figToSave);
    colormap(figToSave,'hot');
    set(newax, 'units', 'normalized', 'position', [0.13 0.11 0.775 0.815]);
    print(figToSave,'-dpng',sprintf('VisualiSAM%03d.png',M));
    axes(h);
end

if options.saveDotFiles
    isam.saveGraph(sprintf('VisualiSAM%03d.dot',M));
end

if options.saveDotFile
    isam.saveGraph(sprintf('VisualiSAM.dot'));
end

if options.printStats
    isam.printStats();
end