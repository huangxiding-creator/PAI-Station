.class public Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;
.super Ljava/lang/Object;
.source "ObjectExpirationHeaderHandler.java"

# interfaces
.implements Lcom/amazonaws/services/s3/internal/HeaderHandler;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T::",
        "Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/amazonaws/services/s3/internal/HeaderHandler<",
        "TT;>;"
    }
.end annotation


# static fields
.field private static final DATE_PATTERN:Ljava/util/regex/Pattern;

.field private static final RULE_PATTERN:Ljava/util/regex/Pattern;

.field private static final log:Lcom/amazonaws/logging/Log;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 39
    nop

    .line 40
    const-string v0, "expiry-date=\"(.*?)\""

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->DATE_PATTERN:Ljava/util/regex/Pattern;

    .line 41
    nop

    .line 42
    const-string v0, "rule-id=\"(.*?)\""

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->RULE_PATTERN:Ljava/util/regex/Pattern;

    .line 44
    nop

    .line 45
    const-class v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->log:Lcom/amazonaws/logging/Log;

    .line 44
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 32
    .local p0, "this":Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;, "Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private parseDate(Ljava/lang/String;)Ljava/util/Date;
    .locals 5
    .param p1, "expirationHeader"    # Ljava/lang/String;

    .line 73
    .local p0, "this":Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;, "Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler<TT;>;"
    sget-object v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->DATE_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    .line 74
    .local v0, "matcher":Ljava/util/regex/Matcher;
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 75
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    .line 77
    .local v1, "date":Ljava/lang/String;
    :try_start_0
    invoke-static {v1}, Lcom/amazonaws/services/s3/internal/ServiceUtils;->parseRfc822Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 78
    :catch_0
    move-exception v2

    .line 79
    .local v2, "exception":Ljava/lang/Exception;
    sget-object v3, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->log:Lcom/amazonaws/logging/Log;

    const-string v4, "Error parsing expiry-date from x-amz-expiration header."

    invoke-interface {v3, v4, v2}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 85
    .end local v1    # "date":Ljava/lang/String;
    .end local v2    # "exception":Ljava/lang/Exception;
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private parseRuleId(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "expirationHeader"    # Ljava/lang/String;

    .line 65
    .local p0, "this":Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;, "Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler<TT;>;"
    sget-object v0, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->RULE_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    .line 66
    .local v0, "matcher":Ljava/util/regex/Matcher;
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 67
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 69
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method


# virtual methods
.method public handle(Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;Lcom/amazonaws/http/HttpResponse;)V
    .locals 2
    .param p2, "response"    # Lcom/amazonaws/http/HttpResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/amazonaws/http/HttpResponse;",
            ")V"
        }
    .end annotation

    .line 55
    .local p0, "this":Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;, "Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler<TT;>;"
    .local p1, "result":Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;, "TT;"
    nop

    .line 56
    invoke-virtual {p2}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string/jumbo v1, "x-amz-expiration"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 58
    .local v0, "expirationHeader":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 59
    invoke-direct {p0, v0}, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->parseDate(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v1

    invoke-interface {p1, v1}, Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;->setExpirationTime(Ljava/util/Date;)V

    .line 60
    invoke-direct {p0, v0}, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->parseRuleId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1}, Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;->setExpirationTimeRuleId(Ljava/lang/String;)V

    .line 62
    :cond_0
    return-void
.end method

.method public bridge synthetic handle(Ljava/lang/Object;Lcom/amazonaws/http/HttpResponse;)V
    .locals 0

    .line 32
    .local p0, "this":Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;, "Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler<TT;>;"
    check-cast p1, Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;

    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/internal/ObjectExpirationHeaderHandler;->handle(Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;Lcom/amazonaws/http/HttpResponse;)V

    return-void
.end method
