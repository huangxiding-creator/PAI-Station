.class public final Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoIdentityProviderClientConfig;
.super Ljava/lang/Object;
.source "CognitoIdentityProviderClientConfig.java"


# static fields
.field private static final REFRESH_THRESHOLD_DEFAULT:J = 0x1d4c0L

.field private static final REFRESH_THRESHOLD_MAX:J = 0x1b7740L

.field private static final REFRESH_THRESHOLD_MIN:J

.field private static refreshThreshold:J


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 46
    const-wide/32 v0, 0x1d4c0

    sput-wide v0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoIdentityProviderClientConfig;->refreshThreshold:J

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getRefreshThreshold()J
    .locals 2

    .line 66
    sget-wide v0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoIdentityProviderClientConfig;->refreshThreshold:J

    return-wide v0
.end method

.method public static setRefreshThreshold(J)V
    .locals 5
    .param p0, "threshold"    # J

    .line 54
    const-wide/32 v0, 0x1b7740

    cmp-long v2, p0, v0

    const-wide/16 v3, 0x0

    if-gtz v2, :cond_0

    cmp-long v2, p0, v3

    if-ltz v2, :cond_0

    .line 59
    sput-wide p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/CognitoIdentityProviderClientConfig;->refreshThreshold:J

    .line 60
    return-void

    .line 55
    :cond_0
    new-instance v2, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/exceptions/CognitoParameterInvalidException;

    .line 57
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    filled-new-array {v3, v0}, [Ljava/lang/Object;

    move-result-object v0

    .line 56
    const-string v1, "The value of refreshThreshold must between %d and %d milliseconds"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/exceptions/CognitoParameterInvalidException;-><init>(Ljava/lang/String;)V

    throw v2
.end method
