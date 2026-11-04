.class public Lcom/amazonaws/internal/DynamoDBBackoffStrategy;
.super Lcom/amazonaws/internal/CustomBackoffStrategy;
.source "DynamoDBBackoffStrategy.java"


# static fields
.field public static final DEFAULT:Lcom/amazonaws/internal/CustomBackoffStrategy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 37
    new-instance v0, Lcom/amazonaws/internal/DynamoDBBackoffStrategy;

    invoke-direct {v0}, Lcom/amazonaws/internal/DynamoDBBackoffStrategy;-><init>()V

    sput-object v0, Lcom/amazonaws/internal/DynamoDBBackoffStrategy;->DEFAULT:Lcom/amazonaws/internal/CustomBackoffStrategy;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Lcom/amazonaws/internal/CustomBackoffStrategy;-><init>()V

    return-void
.end method


# virtual methods
.method public getBackoffPeriod(I)I
    .locals 4
    .param p1, "retries"    # I

    .line 22
    if-gtz p1, :cond_0

    .line 23
    const/4 v0, 0x0

    return v0

    .line 26
    :cond_0
    add-int/lit8 v0, p1, -0x1

    int-to-double v0, v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    invoke-static {v2, v3, v0, v1}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    double-to-int v0, v0

    mul-int/lit8 v0, v0, 0x32

    .line 28
    .local v0, "delay":I
    if-gez v0, :cond_1

    .line 29
    const v0, 0x7fffffff

    .line 32
    :cond_1
    return v0
.end method
