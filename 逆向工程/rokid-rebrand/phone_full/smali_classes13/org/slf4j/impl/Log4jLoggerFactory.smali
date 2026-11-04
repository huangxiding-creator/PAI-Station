.class public Lorg/slf4j/impl/Log4jLoggerFactory;
.super Ljava/lang/Object;
.source "Log4jLoggerFactory.java"

# interfaces
.implements Lorg/slf4j/ILoggerFactory;


# instance fields
.field loggerMap:Ljava/util/concurrent/ConcurrentMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentMap<",
            "Ljava/lang/String;",
            "Lorg/slf4j/Logger;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lorg/slf4j/impl/Log4jLoggerFactory;->loggerMap:Ljava/util/concurrent/ConcurrentMap;

    .line 47
    return-void
.end method


# virtual methods
.method public getLogger(Ljava/lang/String;)Lorg/slf4j/Logger;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;

    .line 55
    iget-object v0, p0, Lorg/slf4j/impl/Log4jLoggerFactory;->loggerMap:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v0, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/slf4j/Logger;

    .line 56
    .local v0, "slf4jLogger":Lorg/slf4j/Logger;
    if-eqz v0, :cond_0

    .line 57
    return-object v0

    .line 60
    :cond_0
    const-string v1, "ROOT"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 61
    invoke-static {}, Lorg/apache/log4j/LogManager;->getRootLogger()Lorg/apache/log4j/Logger;

    move-result-object v1

    .local v1, "log4jLogger":Lorg/apache/log4j/Logger;
    goto :goto_0

    .line 63
    .end local v1    # "log4jLogger":Lorg/apache/log4j/Logger;
    :cond_1
    invoke-static {p1}, Lorg/apache/log4j/LogManager;->getLogger(Ljava/lang/String;)Lorg/apache/log4j/Logger;

    move-result-object v1

    .line 65
    .restart local v1    # "log4jLogger":Lorg/apache/log4j/Logger;
    :goto_0
    new-instance v2, Lorg/slf4j/impl/Log4jLoggerAdapter;

    invoke-direct {v2, v1}, Lorg/slf4j/impl/Log4jLoggerAdapter;-><init>(Lorg/apache/log4j/Logger;)V

    .line 66
    .local v2, "newInstance":Lorg/slf4j/Logger;
    iget-object v3, p0, Lorg/slf4j/impl/Log4jLoggerFactory;->loggerMap:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v3, p1, v2}, Ljava/util/concurrent/ConcurrentMap;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/slf4j/Logger;

    .line 67
    .local v3, "oldInstance":Lorg/slf4j/Logger;
    if-nez v3, :cond_2

    move-object v4, v2

    goto :goto_1

    :cond_2
    move-object v4, v3

    :goto_1
    return-object v4
.end method
