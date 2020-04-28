%% Main Function Speech Recognition
function []=speechrecognition()
% For clear screen
clc;
% Ronaldo is a variable used to directly set the minimum distance for
% speech recognition.
ronaldo=10;
% Drogba is a variable used to directly set the maximum number of
% users stored in database
drogba=8;
% st, st1, st2, st3,  will be used for filenames related purposes reducing
% code redundancy.
char st; char st1; char st2; char st3;
disp('An Approach Using Hidden Markov Model To Speech Recognition System');
disp('        Implementation of Speech Recognition System');
disp('           By  Baabu Aravind Vellaian Selvarajan');
disp('         University of Regina - Summer/Spring 2015');
disp('               Guided By Prof. David Gerhard')
disp(' ');
pause(0.5);
disp('Loading ');
fprintf('\b');
pause(1);
fprintf('\b');
disp('. ');
fprintf('\b');
pause(1);
fprintf('\b');
disp('. ');
fprintf('\b');
pause(1);
fprintf('\b');
disp('. ');

% Preallocating array
str = {8}; fstr = {8}; nbtr = {8};
ste = {8}; fste = {8}; nbte = {8};
ctr = {8}; dtr={8};
cte = {8}; dte={8};
data = {drogba,4};
code = {8};

for i = 1:8

    % Read audio data from train folder for performing operations
    st=strcat('train\s',num2str(i),'.wav');
    [s1 fs1 nb1]=wavread(st);
    str{i} = s1; fstr{i} = fs1; nbtr{i} = nb1;

    % Read audio data from test folder for performing operations
    st = strcat('test\s',num2str(i),'.wav');
    [st1 fst1 nbt1] = audioread(st);
    ste{i} = st1; fste{i} = fst1; nbte{i} = nbt1;

    % Compute MFCC of the audio data to be used in Speech Processing for Train
    % Folder
    ctr{i} = mfcc(str{i},fstr{i});

    % Compute MFCC of the audio data to be used in Speech Processing for Test
    % Folder
    cte{i} = mfcc(ste{i},fste{i});

    % Compute Vector Quantization of the audio data to be used in Speech
    % Processing for Train Folder
    dtr{i} = vqlbg(ctr{i},16);

    % Compute Vector Quantization of the audio data to be used in Speech
    % Processing for Test Folder
    dte{i} = vqlbg(cte{i},16);
end



%%  Speech Recognition by letting user enter into database and then compare
    %Speech recognition is the process of automatically recognizing who is
    %speaking on the basis of individual information included in speech waves.
    %
    %This technique makes it possible to use the speaker's voice to verify
    %their identity and control access to services such as voice dialing,
    %telephone shopping, database access services, information
    %services, voice mail, and remote access to computers.
    

        chos=0;
        possibility=5;
        while chos~=possibility,
            chos=menu('Speaker Recognition System','Add a new sound from microphone',...
                'Speaker recognition from microphone',...
                'Database Info','Delete database','Exit');

            %----------------------------------------------------------------------

%% 10.1 Add a new sound from microphone

            if chos==1

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');                   
                    classe = input('Insert a class number (sound ID) that will be used for recognition:');
                    if isempty(classe)
                        classe = sound_number+1;
                        disp( num2str(classe) );
                    end
                    message=('The following parameters will be used during recording:');
                    disp(message);
                    message=strcat('Sampling frequency',num2str(samplingfrequency));
                    disp(message);
                    message=strcat('Bits per sample',num2str(samplingbits));
                    disp(message);
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);
                    
                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y1 = getaudiodata(micrecorder);
                    y = getaudiodata(micrecorder, 'uint8');

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    sound_number = sound_number+1;
                    data{sound_number,1} = y;
                    data{sound_number,2} = classe;
                    data{sound_number,3} = 'Microphone';
                    data{sound_number,4} = 'Microphone';
                    st=strcat('u',num2str(sound_number));
                    wavwrite(y1,samplingfrequency,samplingbits,st)
                    save('sound_database.dat','data','sound_number','-append');
                    msgbox('Sound added to database','Database result');
                    disp('Sound added to database');

                else
                    classe = input('Insert a class number (sound ID) that will be used for recognition:');
                    if isempty(classe)
                        classe = 1;
                        disp( num2str(classe) );
                    end
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    samplingfrequency = input('Insert the sampling frequency (22050 recommended):');
                    if isempty(samplingfrequency )
                        samplingfrequency = 22050;
                        disp( num2str(samplingfrequency) );
                    end
                    samplingbits = input('Insert the number of bits per sample (8 recommended):');
                    if isempty(samplingbits )
                        samplingbits = 8;
                        disp( num2str(samplingbits) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);

                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y1 = getaudiodata(micrecorder);
                    y = getaudiodata(micrecorder, 'uint8');

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    sound_number = 1;
                    data{sound_number,1} = y;
                    data{sound_number,2} = classe;
                    data{sound_number,3} = 'Microphone';
                    data{sound_number,4} = 'Microphone';
                    st=strcat('u',num2str(sound_number));
                    wavwrite(y1,samplingfrequency,samplingbits,st)
                    save('sound_database.dat','data','sound_number','samplingfrequency','samplingbits');
                    msgbox('Sound added to database','Database result','help');
                    disp('Sound added to database');
                end
            end

            %----------------------------------------------------------------------

%% 10.2 Voice Recognition from microphone

            if chos==2

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');
                    Fs = samplingfrequency;
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);

                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y = getaudiodata(micrecorder);
                    st='v';
                    wavwrite(y,samplingfrequency,samplingbits,st);
                    y = getaudiodata(micrecorder, 'uint8');
                    % if the input sound is not mono

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    %----- code for speaker recognition -------
                    disp('MFCC cofficients computation and VQ codebook training in progress...');
                    disp(' ');
                    % Number of centroids required
                    k =16;

                    for ii=1:sound_number
                        % Compute MFCC cofficients for each sound present in database
                        v = mfcc(data{ii,1}, Fs);
                        % Train VQ codebook
                        code{ii} = vqlbg(v, k);
                        disp('...');
                    end
                    disp('Completed.');
                    % Compute MFCC coefficients for input sound
                    v = mfcc(y,Fs);
                    % Current distance and sound ID initialization
                    distmin = Inf;
                    k1 = 0;

                    for ii=1:sound_number
                        d = disteu(v, code{ii});
                        dist = sum(min(d,[],2)) / size(d,1);
                        message=strcat('For User #',num2str(ii),' Dist : ',num2str(dist));
                        disp(message);
             
                        if dist < distmin
                            distmin = dist;
                            k1 = ii;
                        end
                    end

                    if distmin < ronaldo
                        min_index = k1;
                        speech_id = data{min_index,2};
                        %-----------------------------------------
                        disp('Matching sound:');
                        message=strcat('File:',data{min_index,3});
                        disp(message);
                        message=strcat('Location:',data{min_index,4});
                        disp(message);
                        message = strcat('Recognized speaker ID: ',num2str(speech_id));
                        disp(message);
                        msgbox(message,'Matching result','help');

                        ch3=0;
                        while ch3~=2
                            ch3=menu('Matched result verification:','Recorded sound','Exit');

                           

                            if ch3==1
                                [s fs nb]=wavread('v');
                                p=audioplayer(s,fs,nb);
                                play(p);
                            end
                        end

                    else
                        msgbox('Wrong User . No matching Result.',' Warning ')
                    end
                else
                    msgbox('Database is empty. No matching is possible.',' Warning ')
                end
            end
            %----------------------------------------------------------------------

%% 10.3 Database Info

            if chos==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');
                    message=strcat('Database has #',num2str(sound_number),'words:');
                    disp(message);
                    disp(' ');

                    for ii=1:sound_number
                        message=strcat('Location:',data{ii,3});
                        disp(message);
                        message=strcat('File:',data{ii,4});
                        disp(message);
                        message=strcat('Sound ID:',num2str(data{ii,2}));
                        disp(message);
                        disp('-');
                    end

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs nb]=wavread(st);
                                    p=audioplayer(s,fs,nb);
                                    play(p);
                                else
                                    msgbox('Invalid Word ','Warning');
                                end
                            end
                        end
                    end

                else
                    msgbox('Database is empty.',' Warning ')
                end
            end
            %----------------------------------------------------------------------

%% 10.4 Delete database

            if chos==4
                %clc;
                close all;

                if (exist('sound_database.dat','file')==2)
                    button = questdlg('Do you really want to remove the Database?');

                    if strcmp(button,'Yes')
                        load('sound_database.dat','-mat');

                        for ii=1:sound_number
                            st=strcat('u',num2str(ii),'.wav');
                            delete(st);
                        end

                        if (exist('v.wav','file')==2)
                            delete('v.wav');
                        end

                        delete('sound_database.dat');
                        msgbox('Database was succesfully removed from the current directory.','Database removed');
                    end

                else
                    msgbox('Database is empty',' Warning ')
                end
            end
        end
   % end

%end
close all;
msgbox('Thanks for Using this, Have a nice day...!');
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Acknowledgement to
% Mahima Garg, Omar Razi, Supriya Phutela, Vaibhav Kapoor, Varun Chopra
%--------------------------------------------------------------------------
