function sinzeros=filter_sin(SINZEROS)

jj=1;
   for j=1:length(SINZEROS)
       if (real(SINZEROS(j))>0)&&(imag(SINZEROS(j))>0)
           sinzeros(jj)=SINZEROS(j);
           jj=jj+1;
       end
   end
   
end