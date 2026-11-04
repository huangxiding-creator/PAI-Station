.class public final enum Lcom/amazonaws/services/s3/internal/BucketNameUtils;
.super Ljava/lang/Enum;
.source "BucketNameUtils.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/s3/internal/BucketNameUtils;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/s3/internal/BucketNameUtils;

.field private static final IP_ADDRESS_PATTERN:Ljava/util/regex/Pattern;

.field private static final MAX_BUCKET_NAME_LENGTH:I = 0x3f

.field private static final MIN_BUCKET_NAME_LENGTH:I = 0x3


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 25
    const/4 v0, 0x0

    new-array v0, v0, [Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    sput-object v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->$VALUES:[Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    .line 31
    const-string v0, "(\\d+\\.){3}\\d+"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->IP_ADDRESS_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 26
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method private static exception(ZLjava/lang/String;)Z
    .locals 1
    .param p0, "exception"    # Z
    .param p1, "message"    # Ljava/lang/String;

    .line 187
    if-nez p0, :cond_0

    .line 190
    const/4 v0, 0x0

    return v0

    .line 188
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static isDNSBucketName(Ljava/lang/String;)Z
    .locals 1
    .param p0, "bucketName"    # Ljava/lang/String;

    .line 73
    invoke-static {p0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->isValidV2BucketName(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static isValidV2BucketName(Ljava/lang/String;)Z
    .locals 1
    .param p0, "bucketName"    # Ljava/lang/String;

    .line 62
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->isValidV2BucketName(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private static isValidV2BucketName(Ljava/lang/String;Z)Z
    .locals 6
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "throwOnError"    # Z

    .line 88
    if-nez p0, :cond_0

    .line 89
    const-string v0, "Bucket name cannot be null"

    invoke-static {p1, v0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v0

    return v0

    .line 92
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_12

    .line 93
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x3f

    if-le v0, v1, :cond_1

    goto/16 :goto_4

    .line 101
    :cond_1
    sget-object v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->IP_ADDRESS_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 102
    const-string v0, "Bucket name must not be formatted as an IP Address"

    invoke-static {p1, v0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v0

    return v0

    .line 107
    :cond_2
    const/4 v0, 0x0

    .line 109
    .local v0, "previous":C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0x2d

    const/16 v4, 0x2e

    if-ge v1, v2, :cond_e

    .line 110
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 112
    .local v2, "next":C
    const/16 v5, 0x41

    if-lt v2, v5, :cond_3

    const/16 v5, 0x5a

    if-gt v2, v5, :cond_3

    .line 113
    const-string v3, "Bucket name should not contain uppercase characters"

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 118
    :cond_3
    const/16 v5, 0x20

    if-eq v2, v5, :cond_d

    const/16 v5, 0x9

    if-eq v2, v5, :cond_d

    const/16 v5, 0xd

    if-eq v2, v5, :cond_d

    const/16 v5, 0xa

    if-ne v2, v5, :cond_4

    goto :goto_2

    .line 124
    :cond_4
    const-string v5, "Bucket name should not contain dashes next to periods"

    if-ne v2, v4, :cond_7

    .line 125
    if-nez v0, :cond_5

    .line 126
    const-string v3, "Bucket name should not begin with a period"

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 130
    :cond_5
    if-ne v0, v4, :cond_6

    .line 131
    const-string v3, "Bucket name should not contain two adjacent periods"

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 135
    :cond_6
    if-ne v0, v3, :cond_b

    .line 136
    invoke-static {p1, v5}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 140
    :cond_7
    if-ne v2, v3, :cond_9

    .line 141
    if-ne v0, v4, :cond_8

    .line 142
    invoke-static {p1, v5}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 146
    :cond_8
    if-nez v0, :cond_b

    .line 147
    const-string v3, "Bucket name should not begin with a \'-\'"

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 151
    :cond_9
    const/16 v3, 0x30

    if-lt v2, v3, :cond_c

    const/16 v3, 0x39

    if-le v2, v3, :cond_a

    const/16 v3, 0x61

    if-lt v2, v3, :cond_c

    :cond_a
    const/16 v3, 0x7a

    if-le v2, v3, :cond_b

    goto :goto_1

    .line 160
    :cond_b
    move v0, v2

    .line 109
    .end local v2    # "next":C
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 155
    .restart local v2    # "next":C
    :cond_c
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Bucket name should not contain \'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 119
    :cond_d
    :goto_2
    const-string v3, "Bucket name should not contain white space"

    invoke-static {p1, v3}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v3

    return v3

    .line 163
    .end local v1    # "i":I
    .end local v2    # "next":C
    :cond_e
    if-eq v0, v4, :cond_11

    if-ne v0, v3, :cond_f

    goto :goto_3

    .line 171
    :cond_f
    const-string v1, "."

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_10

    .line 172
    const/4 v1, 0x0

    return v1

    .line 175
    :cond_10
    const/4 v1, 0x1

    return v1

    .line 164
    :cond_11
    :goto_3
    const-string v1, "Bucket name should not end with \'-\' or \'.\'"

    invoke-static {p1, v1}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v1

    return v1

    .line 95
    .end local v0    # "previous":C
    :cond_12
    :goto_4
    const-string v0, "Bucket name should be between 3 and 63 characters long"

    invoke-static {p1, v0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->exception(ZLjava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static validateBucketName(Ljava/lang/String;)V
    .locals 1
    .param p0, "bucketName"    # Ljava/lang/String;

    .line 48
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->isValidV2BucketName(Ljava/lang/String;Z)Z

    .line 49
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/BucketNameUtils;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 25
    const-class v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/s3/internal/BucketNameUtils;
    .locals 1

    .line 25
    sget-object v0, Lcom/amazonaws/services/s3/internal/BucketNameUtils;->$VALUES:[Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    invoke-virtual {v0}, [Lcom/amazonaws/services/s3/internal/BucketNameUtils;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/s3/internal/BucketNameUtils;

    return-object v0
.end method
