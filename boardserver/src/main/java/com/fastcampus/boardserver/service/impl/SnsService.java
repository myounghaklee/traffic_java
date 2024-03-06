package com.fastcampus.boardserver.service.impl;

@Service
public class SnsService {

    AWSConfig awsConfig;

    public SnsService(AWSConfig awsConfig) {
        this.awsConfig = awsConfig;
    }

    public AwsCredentialsProvider getAwsCredentials(String accessKeyID, String secretAccessKey) {
        AwsBasicCredentials awsBasicCredentials = AwsBasicCredentials.create(accessKeyID, secretAccessKey);
        return () -> awsBasicCredentials;
    }

    public SnsClient getSnsClient() {
        return SnsClient.builder()
                .credentialsProvider(
                        getAwsCredentials(awsConfig.getAwsAccessKey(), awsConfig.getAwsSecretKey())
                ).region(Region.of(awsConfig.getAwsRegion()))
                .build();
    }

}
