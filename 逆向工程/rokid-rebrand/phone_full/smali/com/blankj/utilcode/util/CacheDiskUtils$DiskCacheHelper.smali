.class final Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;
.super Ljava/lang/Object;
.source "CacheDiskUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/CacheDiskUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "DiskCacheHelper"
.end annotation


# static fields
.field static final TIME_INFO_LEN:I = 0xe


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 809
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100(I[B)[B
    .locals 1
    .param p0, "x0"    # I
    .param p1, "x1"    # [B

    .line 809
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->newByteArrayWithTime(I[B)[B

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$600([B)Z
    .locals 1
    .param p0, "x0"    # [B

    .line 809
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->isDue([B)Z

    move-result v0

    return v0
.end method

.method static synthetic access$800([B)[B
    .locals 1
    .param p0, "x0"    # [B

    .line 809
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->getDataWithoutDueTime([B)[B

    move-result-object v0

    return-object v0
.end method

.method private static copyOfRange([BII)[B
    .locals 4
    .param p0, "original"    # [B
    .param p1, "from"    # I
    .param p2, "to"    # I

    .line 859
    sub-int v0, p2, p1

    .line 860
    .local v0, "newLength":I
    if-ltz v0, :cond_0

    .line 861
    new-array v1, v0, [B

    .line 862
    .local v1, "copy":[B
    array-length v2, p0

    sub-int/2addr v2, p1

    invoke-static {v2, v0}, Ljava/lang/Math;->min(II)I

    move-result v2

    const/4 v3, 0x0

    invoke-static {p0, p1, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 863
    return-object v1

    .line 860
    .end local v1    # "copy":[B
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " > "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static createDueTime(I)Ljava/lang/String;
    .locals 5
    .param p0, "seconds"    # I

    .line 829
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 830
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const-wide/16 v3, 0x3e8

    div-long/2addr v1, v3

    int-to-long v3, p0

    add-long/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 828
    const-string v2, "_$%010d$_"

    invoke-static {v0, v2, v1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static getDataWithoutDueTime([B)[B
    .locals 2
    .param p0, "data"    # [B

    .line 852
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->hasTimeInfo([B)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 853
    const/16 v0, 0xe

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->copyOfRange([BII)[B

    move-result-object v0

    return-object v0

    .line 855
    :cond_0
    return-object p0
.end method

.method private static getDueTime([B)J
    .locals 5
    .param p0, "data"    # [B

    .line 840
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->hasTimeInfo([B)Z

    move-result v0

    const-wide/16 v1, -0x1

    if-eqz v0, :cond_0

    .line 841
    new-instance v0, Ljava/lang/String;

    const/4 v3, 0x2

    const/16 v4, 0xc

    invoke-static {p0, v3, v4}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->copyOfRange([BII)[B

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/lang/String;-><init>([B)V

    .line 843
    .local v0, "millis":Ljava/lang/String;
    :try_start_0
    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    const-wide/16 v3, 0x3e8

    mul-long/2addr v1, v3

    return-wide v1

    .line 844
    :catch_0
    move-exception v3

    .line 845
    .local v3, "e":Ljava/lang/NumberFormatException;
    return-wide v1

    .line 848
    .end local v0    # "millis":Ljava/lang/String;
    .end local v3    # "e":Ljava/lang/NumberFormatException;
    :cond_0
    return-wide v1
.end method

.method private static hasTimeInfo([B)Z
    .locals 5
    .param p0, "data"    # [B

    .line 867
    const/4 v0, 0x0

    if-eqz p0, :cond_0

    array-length v1, p0

    const/16 v2, 0xe

    if-lt v1, v2, :cond_0

    aget-byte v1, p0, v0

    const/16 v2, 0x5f

    if-ne v1, v2, :cond_0

    const/4 v1, 0x1

    aget-byte v3, p0, v1

    const/16 v4, 0x24

    if-ne v3, v4, :cond_0

    const/16 v3, 0xc

    aget-byte v3, p0, v3

    if-ne v3, v4, :cond_0

    const/16 v3, 0xd

    aget-byte v3, p0, v3

    if-ne v3, v2, :cond_0

    move v0, v1

    :cond_0
    return v0
.end method

.method private static isDue([B)Z
    .locals 4
    .param p0, "data"    # [B

    .line 835
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->getDueTime([B)J

    move-result-wide v0

    .line 836
    .local v0, "millis":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    if-eqz v2, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    cmp-long v2, v2, v0

    if-lez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method private static newByteArrayWithTime(I[B)[B
    .locals 5
    .param p0, "second"    # I
    .param p1, "data"    # [B

    .line 814
    invoke-static {p0}, Lcom/blankj/utilcode/util/CacheDiskUtils$DiskCacheHelper;->createDueTime(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 815
    .local v0, "time":[B
    array-length v1, v0

    array-length v2, p1

    add-int/2addr v1, v2

    new-array v1, v1, [B

    .line 816
    .local v1, "content":[B
    array-length v2, v0

    const/4 v3, 0x0

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 817
    array-length v2, v0

    array-length v4, p1

    invoke-static {p1, v3, v1, v2, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 818
    return-object v1
.end method
